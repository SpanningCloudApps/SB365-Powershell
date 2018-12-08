function Disable-SpanningUsersfromCSVAdvanced {

    [CmdletBinding(SupportsShouldProcess=$true,
        DefaultParametersetName='None')]
    param(
        [Parameter(
            Position=0,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #The AuthInfo result from Get-SpanningAuthentication. If not provided the Script varable will be checked. If null you will be prompted.
        $AuthInfo,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty]
        [String]
        #Path to the CSV file
        $Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty]
        [Int]
        #Column index containing the Use Principal Name
        $UpnColumn,
        [Parameter(ParameterSetName='Filter',
            Mandatory = $false)]
        [ValidateNotNullOrEmpty]
        [Int]
        #Column index of the column to filter on
        $FilterColumn,
        [Parameter(ParameterSetName='Filter',
            Mandatory = $true)]
        [ValidateNotNullOrEmpty]
        [String]
        #Filter string to apply to filter column for comparison
        $FilterColumnValue
    )
    # get column headers because this is one of those areas that Powershell makes life unnecessarily difficult
    $csvColumnNames = (Get-Content $Path | Select-Object -First 1).Split(",")
    $seek_column = $csvColumnNames[$FilterColumn] -replace '"', ""
    $source_column = $csvColumnNames[$UpnColumn] -replace '"', ""

    #import the CSV file
    $whole_csv = Import-CSV -path $Path

    #import only the matching rows
    if ($FilterColumn -and $FilterColumnValue)
    {
        Write-Verbose "Importing from csv on column $($seek_column) with value $($FilterColumnValue)"
        $match_csv = Import-CSV -path $Path | Where-Object {$_.$seek_column -eq $FilterColumnValue}
    } else {
        $match_csv = Import-CSV -path $Path
    }

    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo
     }
     #$headers = usernfo[0]
     $headers = $AuthInfo.Headers
     #$region = usernfo[1]
     $region = $AuthInfo.Region

    # import users list so we can validate
    $existing_list = Get-SpanningUsers

    # get list of assigned users so we can do a delta
    $assigned_users = Get-SpanningAssignedUsers

    # and now we can start doing things with it

    Write-Verbose "$($whole_csv.count) rows in CSV"
    Write-Verbose "$($match_csv.count) matches in CSV"
    Write-Verbose "$($assigned_users.count) Spanning users currently assigned"
    Write-Verbose "Processing..."

    $disableCount = 0
    # begin looping through the matched CSV
    foreach ($user in $match_csv) {

        #unassign UPN in designated column
        $UserPrincipalName = $user.$source_column
        Write-Verbose "Processing $($UserPrincipalName)"

        #validate against existing users so we don't throw an error
        if ($existing_list.userPrincipalName -notcontains $userPrincipalName) {
            Write-Verbose "User $($UserPrincipalName) was not found in list. Proceeding to next user"
            continue
        }

        #once validated, we can actually execute the disable command
        $disableCount++
         if ($pscmdlet.ShouldProcess("$UserPrincipalName", "Disable-SpanningUser")){
            $uri = "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/unassign"
            #$uri
            $results = Invoke-WebRequest -uri $uri -Headers $headers -Method POST | ConvertFrom-Json
            Write-Verbose "Processing for user '$($UserPrincipalName)' complete"
            #$results
         }
    }

    if ($pscmdlet.ShouldProcess("Count of users to disable $($disableCount)")){
        $updated_users = Get-SpanningAssignedUsers
        Write-Verbose "$($updated_users.count) Users are now enabled for Spanning"
    }


}

