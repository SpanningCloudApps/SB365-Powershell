function Get-SpanningTenantBackupSummary {
    <#
    .SYNOPSIS
        Returns the tenant backup summary information
    .DESCRIPTION
        Returns the tenant backup summary information from the Spanning Backup Portal. Backup Summary is availalable for the past 7 days.
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER StartDate
        This parameter takes a Date for the beginning date range. A maximum of 7 days is available.
    .PARAMETER EndDate
        This parameter takes a Date for the ending date range.
    .EXAMPLE
        Get-SpanningTenantBackupSummary
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called. The default is for today.
    .EXAMPLE
        $myApiToken = "your api token"
        $myAdminEmail = "admin@mytenant.onmicrosoft.com"
        $myRegion = "US"

        Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail | Get-SpanningTenantBackupSummary

        Supply the three parameters from variables to Get-SpanningAuthentication and pipe the result to Get-SpanningTenantBackupSummary
.EXAMPLE
        Get-SpanningTenantBackupSummary -StartDate (Get-Date).AddDays(-5)
        Call with StartDate 5 days in the past. The default EndDate is today.
.EXAMPLE
        Get-SpanningTenantBackupSummary -StartDate "11/21/2020" -EndDate "11/23/2020"
        Request a specific time frame, no more that 7 days in the past.

    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Get-SpanningTenantInfo
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
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #Starting date of the tenant backup summary query
        [datetime]$StartDate,
        [Parameter(
            Position=2,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #Ending date of the tenant backup summary query
        [datetime]$EndDate
    )
    Write-Verbose "Get-SpanningTenantBackupSummary"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }

    if ($StartDate)
    {
        if ($EndDate)
        {
            # Tenant Backup Summary Request with Start and End
            $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType TenantBackupSummary -StartDate $StartDate -EndDate $EndDate
        }
        else {
            # Tenant Backup Summary Request with Start only
            $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType TenantBackupSummary -StartDate $StartDate
        }
    }
    else {
        # Tenant Backup Summary Request
        $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType TenantBackupSummary
    }

    Write-Output $results
}

