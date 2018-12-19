function Get-SpanningTenantInfo {
    <#
    .SYNOPSIS
        Returns the tenant information from the Spanning Backup Portal
    .DESCRIPTION
        Returns the tenant information from the Spanning Backup Portal for the supplied ApiToken, Region, and AdminEmail address
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .EXAMPLE
        Get-SpanningTenantInfo
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .EXAMPLE
        $myApiToken = "your api token"
        $myAdminEmail = "admin@mytenant.onmicrosoft.com"
        $myRegion = "US"

        Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail | Get-SpanningTenantInfo

        Supply the three parameters from variables to Get-SpanningAuthentication and pipe the result to Get-SpanningTennantInfo.
    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Get-SpanningTenantInfoPaymentStatus
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
        $AuthInfo
    )
    Write-Verbose "Get-SpanningTenantInfo"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }

    #$headers = usernfo[0]
    $headers = $AuthInfo.Headers
    #$region = usernfo[1]
    $region = $AuthInfo.Region
    $request = "https://o365-api-$region.spanningbackup.com/tenant"
    # $request
    $results = Invoke-WebRequest -uri $request -Headers $headers | ConvertFrom-Json
    Write-Output $results

}

