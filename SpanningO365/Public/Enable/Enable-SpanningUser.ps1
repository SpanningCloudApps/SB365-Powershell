function Enable-SpanningUser {

    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(
            Position=0,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #The AuthInfo result from Get-SpanningAuthentication. If not provided the Script varable will be checked. If null you will be prompted.
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

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo
    }
    #$headers = usernfo[0]
    $headers = $AuthInfo.Headers
    #$region = usernfo[1]
    $region = $AuthInfo.Region
    if ($pscmdlet.ShouldProcess("$UserPrincipalName", "Enable-SpanningUser")){
        #Actually do the work
        Write-Verbose "Assigning license to $($UserPrincipalName)"
        $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName/assign" -Headers $headers -Method POST | ConvertFrom-Json
        Write-Output $results
    }

}

