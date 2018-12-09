<#
.Synopsis
   A utility function, not meant to be called directly. Returns the AuthInfo object based on input parameters.
.DESCRIPTION
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  This function is not caled directly.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-AuthInfo {

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
    Write-Verbose "Get-AuthInfo"
    if (!$AuthInfo) {
        Write-Verbose "Get-AuthInfo: AuthInfo is null"
        if ($Script:AuthInfo)
        {
            Write-Verbose "Get-AuthInfo with AuthInfo from SessionState"
            $AuthInfo = $Script:AuthInfo
        } else  {
            Write-Verbose "Get-AuthInfo with the AuthInfo from Get-SpanningAuthentication"
            $AuthInfo = Get-SpanningAuthentication
        }
    }
    Write-Verbose "Get-AuthInfo with the returns this AuthInfo"
    if ($AuthInfo){
        Write-Verbose "Headers.Authorization: $($AuthInfo.Headers.Authorization)"
        Write-Verbose "Region $($AuthInfo.Region)"
    } else {
        Write-Verbose "Error: AuthInfo is null."
    }

    Write-Output $AuthInfo

}

