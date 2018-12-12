function Disable-SpanningUser {
    <#
    .SYNOPSIS
    Removes the user license from a licensed user
    .DESCRIPTION
    Removes the user license asignment from the Spanning Backup Portal for the supplied user principal name.
    If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
    .PARAMETER AuthInfo
    This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER UserPrincipalName
    This parameter is the UPN of the user to disable.
    .EXAMPLE
    Disable-SpanningUser -UserPrincipalName user@domain.com
    Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .NOTES
    The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Enable-SpanningUser
    .LINK
        GitHub Repository: https://github.com/spanningcloudapps
    #>
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact = 'High')]
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
            ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        #User Principal Name (email address) of the user to disable.
        $UserPrincipalName
    )
    Write-Verbose "Disable-SpanningUser"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }
    #$headers = usernfo[0]
    $headers = $AuthInfo.Headers
    #$region = usernfo[1]
    $region = $AuthInfo.Region

    if ($pscmdlet.ShouldProcess("$UserPrincipalName", "Disable-SpanningUser")){
        #Actually do the work
        Write-Verbose "Disable license for $($UserPrincipalName)"
        $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName/unassign" -Headers $headers -Method POST | ConvertFrom-Json
        Write-Output $results
    }

}

