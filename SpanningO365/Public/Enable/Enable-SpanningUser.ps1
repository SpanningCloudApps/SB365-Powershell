function Enable-SpanningUser {
    <#
    .SYNOPSIS
        [DEPRECATED]
        Apply a license to a user account
    .DESCRIPTION
        Apply a license to the UserPrincipalName.
        If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER UserPrincipalName
        This parameter is the UPN of the user to enable.
    .EXAMPLE
        Enable-SpanningUser -UserPrincipalName user@domain.com
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .NOTES
        [DEPRECATED]
        This function is deprecated. Please use Enable-SpanningUserList instead.
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Get-SpanningUser
    .LINK
        Disable-SpanningUser
    .LINK
        GitHub Repository: https://github.com/spanningcloudapps
    #>
    [CmdletBinding(SupportsShouldProcess=$true)]
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
            Mandatory = $true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String]
        #User Principal Name (email address) of the user to enable.
        $UserPrincipalName
    )
    Write-Verbose "Enable-SpanningUser"

    Write-Warning "Enable-SpanningUser is deprecated, use Enable-SpanningUserList instead"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }

    $userPrincipalNamesJson = ([PSCustomObject]@{
        userPrincipalNames = @($UserPrincipalName)
        } | ConvertTo-Json )

    if ($pscmdlet.ShouldProcess("$UserPrincipalName", "Enable-SpanningUser")){
        #Actually do the work
        Write-Verbose "Assigning license to $($UserPrincipalName)"
        #$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName/assign" -Headers $headers -Method POST | ConvertFrom-Json
        $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType Users -UserPrincipalNames $userPrincipalNamesJson -RequestAction Assign
        $resultObj = [PSCustomObject]@{
            userPrincipalName = $results.userPrincipalNames[0]
            licensed = $results.licensed
            }
        Write-Output $resultObj
    }

}

