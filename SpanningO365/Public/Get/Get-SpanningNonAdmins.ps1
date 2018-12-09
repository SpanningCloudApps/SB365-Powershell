<#
.SYNOPSIS
  Returns the non-admin users from the Spanning Backup Portal
.DESCRIPTION
  Returns the non-admin users information from the Spanning Backup Portal.
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningNonAdmins
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningUser -UserType NonAdmins
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningNonAdmins {

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
        $AuthInfo
    )
    Write-Verbose "Get-SpanningNonAdmins"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo
     }

     Write-Output (Get-SpanningUser -AuthInfo $AuthInfo -UserType NonAdmins)

}

