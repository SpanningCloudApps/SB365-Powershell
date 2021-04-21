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
        [ValidateSet('Tenant','User','Users')]
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
        $Size = 1000
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

    Write-Verbose "Invoke-SpanningRequest Request Type $($RequestType)"

    switch ( $RequestType )
    {
      User
      {
        if ([string]::IsNullOrEmpty($UserPrincipalName))
        {
          Write-Verbose "Invoke-SpanningRequest UPN null"
          Write-Verbose "Invoke-SpanningRequest size parameter is: $Size"

          $request = "$apiRootUrl/users?size=$Size"
           #TODO : Clean this up
          $values2 = @()
          $values = @()
          $response = Invoke-WebRequest -uri $request -Headers $headers -Method GET -UseBasicParsing | ConvertFrom-Json
          $values2 += $response.users
          do {
              $response = Invoke-WebRequest -uri $response.nextLink -Headers $headers -Method GET -UseBasicParsing | ConvertFrom-JSON
              $values += $response.users
          } until ($response.nextlink.Length -eq 0)

          #$values.count
          $values3 = $values2 + $values
          $results = $values3

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
              $request = "$apiRootUrl/users/$UserPrincipalName"
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
    }

    Write-Output $results

}

