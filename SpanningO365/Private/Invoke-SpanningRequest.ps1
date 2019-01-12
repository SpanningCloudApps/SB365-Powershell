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
    .EXAMPLE
        This function is not caled directly.
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
        #The AuthInfo result from Get-SpanningAuthentication. If not provided the Script varable will be checked. If null you will be prompted.
        $AuthInfo,
        [Parameter(
            Position=1,
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [ValidateSet('Tenant','User')]
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
            Position=3,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateSet('Assign','Unassign')]
        [String]
        #Action to take on UPN
        $RequestAction
    )

    Write-Verbose "Invoke-SpanningRequest"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }

    $headers = $AuthInfo.Headers
    $region = $AuthInfo.Region
    $method = "GET"

    Write-Verbose "Invoke-SpanningRequest Request Type $($RequestType)"

    switch ( $RequestType )
    {
      User
      {
        if ([string]::IsNullOrEmpty($UserPrincipalName))
        {
          Write-Verbose "Invoke-SpanningRequest UPN null"
          $request = "https://o365-api-$region.spanningbackup.com/users"
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
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalName) Assign"
              $request = "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/assign"
              $method = "POST"
            }
            Unassign {
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalName) Unassign"
              $request = "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/unassign"
              $method = "POST"
            }
            Default {
              Write-Verbose "Invoke-SpanningRequest $($UserPrincipalName) only"
              $request = "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName"
            }
          }
          Write-Verbose "Invoke-SpanningRequest: $($request)"
          $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method -UseBasicParsing | ConvertFrom-Json
        }
      }
      Tenant
      {
        Write-Verbose "Invoke-SpanningRequest Tenant"
        $request = "https://o365-api-$region.spanningbackup.com/tenant"
        Write-Verbose "Invoke-SpanningRequest: $($request)"
        $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method -UseBasicParsing | ConvertFrom-Json
      }
    }

    Write-Output $results

}

