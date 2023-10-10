function Enable-SpanningUserList {
    <#
    .SYNOPSIS
        Apply a license to a list of user accounts
    .DESCRIPTION
        Apply a license to each user in the array of users.
        If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER UserPrincipalNames
        This parameter is the array of UPNs of the users to enable.
    .EXAMPLE
        $users = "cheyenne@doghousetoys.com","ruby@doghousetoys.com"
        Enable-SpanningUserList -UserPrincipalNames $users -AuthInfo $auth
    .EXAMPLE
        $users = "cheyenne@doghousetoys.com","ruby@doghousetoys.com"
        Enable-SpanningUserList -UserPrincipalNames $users
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
        .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Get-SpanningUser
    .LINK
        Disable-SpanningUserList
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
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="String array of UPNs to enable")]
        [ValidateCount(1,500)]
        [String[]]
        #User Principal Name (email address) of the users to enable.
        $UserPrincipalNames,
        [Parameter(
            Position=9,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateSet('STANDARD','ARCHIVE')]
        [string]
        #Select the license type to apply, Standard or Archive
        $LicenseType = 'STANDARD'
    )
    Write-Verbose "Enable-SpanningUserList"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }

    $userPrincipalNamesJson = ([PSCustomObject]@{
        userPrincipalNames = $UserPrincipalNames
        licenseType = $LicenseType
        } | ConvertTo-Json )

    if ($pscmdlet.ShouldProcess("$UserPrincipalNames", "Enable-SpanningUsers")){
        #Actually do the work
        Write-Verbose "Assigning license to $($userPrincipalNamesJson)"
        $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType Users -UserPrincipalNames $userPrincipalNamesJson -RequestAction Assign
        #$results | ConvertFrom-Json
        Write-Output $results
    }

}

