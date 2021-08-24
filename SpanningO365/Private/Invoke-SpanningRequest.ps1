function Invoke-SpanningRequest {
    <#
    .SYNOPSIS
        A utility function, not meant to be called directly. Requests and returns results from a Spanning Service request.
    .DESCRIPTION
        Used to consolidate requests into a single function.
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER RequestType
        This parameter takes a RequestType of User or Tenant to determine the REST URI.
    .PARAMETER UserPrincipalName
        This parameter takes a UserPrincipalName for single user actions.
    .PARAMETER RequestAction
        This parameter takes a RequestAction to determine an licence to Assign or Unassign.
    .PARAMETER Size
        This parameter takes a page size parameter for the request. It defaults to 1000.
    .PARAMETER Status
        This parameter takes an optional parameter to include the User Backup Status in the result.
        Note, this can significantly increase both the result size and the time required for PowerShell to process the results.
    .EXAMPLE
        This function is not called directly.
    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        GitHub Repository: https://github.com/spanningcloudapps
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="AuthInfo from Get-SpanningAuthentication")
        ]
        #The AuthInfo result from Get-SpanningAuthentication. If not provided the Script variable will be checked. If null you will be prompted.
        $AuthInfo,
        [Parameter(
            Position=1,
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [ValidateSet('Tenant','User','Users','TenantBackupSummary')]
        #Type of request
        [string]$RequestType,
        [Parameter(
            Position=2,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String]
        #User Principal Name (email address) of the user to act on.
        $UserPrincipalName,
        [Parameter(
            Position=2,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String[]]
        #User Principal Names array of the users to act on.
        $UserPrincipalNames,
        [Parameter(
            Position=3,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateSet('Assign','Unassign')]
        [String]
        #Action to take on UPN
        $RequestAction,
        [Parameter(
            Position=4,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [Int]
        #Request Size parameter for User requests, default 1000
        $Size = 1000,
        [Parameter(
            Position=5,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #Starting date of the tenant backup summary query
        [datetime]$StartDate,
        [Parameter(
            Position=6,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #Ending date of the tenant backup summary query
        [datetime]$EndDate,
        [Parameter(
            Position=7,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [bool]
        #Include backup status for users $false by default
        $Status = $false
    )

    Write-Verbose "Invoke-SpanningRequest"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }

    # Force TLS 1.2
    if ([Net.ServicePointManager]::SecurityProtocol -ne [Net.SecurityProtocolType]::SystemDefault){
      Write-Verbose "Applying TLS 1.2"
      [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    }

    $headers = $AuthInfo.Headers
    $region = $AuthInfo.Region
    $method = "GET"
    $apiRootUrl = "https://o365-api-$region.spanningbackup.com/external"

    #ProgressPreference prevents wasted time showing progress. This improves the processing time.
    $ProgressPreference = "SilentlyContinue"

    Write-Verbose "Invoke-SpanningRequest Request Type $($RequestType)"

    switch ( $RequestType )
    {
      User
      {
        if ([string]::IsNullOrEmpty($UserPrincipalName))
        {
          Write-Verbose "Invoke-SpanningRequest UPN null"
          Write-Verbose "Invoke-SpanningRequest size parameter is: $Size"
          Write-Verbose "Invoke-SpanningRequest Status parameter is: $($Status.ToString().ToLower())"

          #$Uri = "$apiRootUrl/users?size=$Size&status=$Status"
          $Uri = "{0}/users?size={1}&status={2}" -f $apiRootUrl, $Size, $Status.ToString().ToLower()

          $retryCount = 0
          $maxRetries = 3
          $pauseDuration = 2
          $allRecords = @()

          while ($null -ne $Uri){
              Write-Verbose "Request URI: $Uri"
              try {

                  $query = Invoke-WebRequest -uri $Uri -Headers $headers -Method GET -UseBasicParsing | ConvertFrom-Json
                  $allRecords += $query.users

                  if($query.nextLink){
                      # set the url to get the next page of records
                      $Uri = $query.nextLink
                  } else {
                      $Uri = $null
                  }

              } catch {
                #TODO : Mock this to test responses
                  Write-Verbose "StatusCode: $($_.Exception.Response.StatusCode.value__)"
                  Write-Verbose "StatusDescription: $($_.Exception.Response.StatusDescription)"

                  if($_.ErrorDetails.Message){
                      Write-Verbose "Inner Error: $_.ErrorDetails.Message"
                  }

                  # Check for a 429 in case we need to slow down
                  if($_.Exception.Response.StatusCode.value__ -eq 429 ){
                      #If it's a 429 you can get the retry after
                      #$retryAfter = $_.Exception.Response.Headers["Retry-After"]
                      # just ignore, leave the url the same to retry but pause first
                      if($retryCount -ge $maxRetries){
                          # not going to retry again
                          $Uri = $null
                          Write-Verbose 'Not going to retry...'
                      } else {
                          $retryCount += 1
                          Write-Verbose "Retry attempt $retryCount after a $pauseDuration second pause..."
                          Start-Sleep -Seconds $pauseDuration
                      }

                  } else {
                      # not going to retry -- set the url to null to fall back out of the while loop
                      $Uri = $null
                  }
              }
          }

          $results = $allRecords #| ConvertTo-Json

          Write-Verbose "Invoke-SpanningRequest User Loop"

        } else {
          switch ($RequestAction) {
            Assign {
              # Single assignment is deprecated
              Write-Warning "Invoke-SpanningRequest $($UserPrincipalName) Assign is deprecated"
              #$request = "$apiRootUrl/users/$userPrincipalName/assign"
              $method = "POST"
            }
            Unassign {
              # Single un-assignment is deprecated
              Write-Warning "Invoke-SpanningRequest $($UserPrincipalName) Unassign is deprecated"
              #$request = "$apiRootUrl/users/$userPrincipalName/unassign"
              $method = "POST"
            }
            Default {
              # Change this to Use the new users/upn TODO Test this path
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalName) only"
              $request = "{0}/users/{1}?status={2}" -f $apiRootUrl, $UserPrincipalName, $Status.ToString().ToLower()
            }
          }
          Write-Verbose "Invoke-SpanningRequest: $($request)"
          $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method -UseBasicParsing | ConvertFrom-Json
        }
      }
      Users
      {
        if ([string]::IsNullOrEmpty($UserPrincipalNames))
        {
          Write-Verbose "Invoke-SpanningRequest UPN[] null"
        } else {
          switch ($RequestAction) {
            Assign {
              # Change for new endpoint
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalNames) Assign"
              #$request = "https://o365-api-$region.spanningbackup.com/users/assign"
              $request = "$apiRootUrl/users/assign"
              $method = "POST"
            }
            Unassign {
              # Change for new endpoint
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalNames) Unassign"
              #$request = "https://o365-api-$region.spanningbackup.com/users/unassign"
              $request = "$apiRootUrl/users/unassign"
              $method = "POST"
            }
            Default {
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalNames) only, no action."
            }
          }
          Write-Verbose "Invoke-SpanningRequest: $($request)"
          $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method -Body $UserPrincipalNames -UseBasicParsing -ContentType "application/json" | ConvertFrom-Json

        }
      }
      Tenant
      {
        Write-Verbose "Invoke-SpanningRequest Tenant"
        $request = "$apiRootUrl/tenant"
        Write-Verbose "Invoke-SpanningRequest: $($request)"
        $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method -UseBasicParsing  | ConvertFrom-Json
      }
      TenantBackupSummary
      {
        Write-Verbose "Invoke-SpanningRequest TenantBackupSummary"

        if ($StartDate)
        {
          # Convert date to Int
          $startDateInt = [Math]::Round((Get-Date -Date $StartDate -UFormat %s)) * 1000
            if ($EndDate)
            {
              # Convert date to Int
              $endDateInt = [Math]::Round((Get-Date -Date $EndDate -UFormat %s)) * 1000
                # Tenant Backup Summary Request with Start and End
                $request = "$apiRootUrl/tenant/backups/summary?start=$startDateInt&end=$endDateInt"
            }
            else {
                # Tenant Backup Summary Request with Start only
                $request = "$apiRootUrl/tenant/backups/summary?start=$startDateInt"
            }
        } else {
            # Tenant Backup Summary Request
            $request = "$apiRootUrl/tenant/backups/summary"
        }

        Write-Verbose "Invoke-SpanningRequest: $($request)"
        $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method -UseBasicParsing  | ConvertFrom-Json
      }
    }

    Write-Output $results

}

