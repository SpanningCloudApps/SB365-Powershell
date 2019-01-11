function Invoke-SpanningRequest {
    <#
    .SYNOPSIS
        A utility function, not meant to be called directly. Requests and returns results from a Spanning Service request.
    .DESCRIPTION
        Used to consolidate requests into a single function.
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
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
      Tenant
      {
        Write-Verbose "Invoke-SpanningRequest Tenant"
        $request = "https://o365-api-$region.spanningbackup.com/tenant"
      }
      User
      {
        if ($UserPrincipalName -eq $null)
        {
          Write-Verbose "Invoke-SpanningRequest UPN null"
          $request = "https://o365-api-$region.spanningbackup.com/users"
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
        }

      }
    }

    Write-Verbose "Invoke-SpanningRequest: $($request)"
    $results = Invoke-WebRequest -uri $request -Headers $headers -Method $method | ConvertFrom-Json

    Write-Output $results

}

