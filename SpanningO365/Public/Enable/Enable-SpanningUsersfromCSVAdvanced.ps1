function Enable-SpanningUsersFromCSVAdvanced {
    <#
    .SYNOPSIS
        Enable licenses for Spanning users from a comma separated value file.
    .DESCRIPTION
        Enable licenses for Spanning users from a comma separated value file.
        If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER Path
        The path to the CSV file.
    .PARAMETER UpnColumn
        The column containing the user UPN.
    .PARAMETER FilterColumn
        The column to apply the filter to.
    .PARAMETER FilterColumnValue
        The value to filter on.
    .EXAMPLE
        Enable-SpanningUsersfromCSVAdvanced -Path .\users.csv -UpnColumn 1 -FilterColumn 2 -FilterColumnValue "Finance"
        Enable the users with a value of Finance in the third column.
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .EXAMPLE
        Enable-SpanningUsersfromCSVAdvanced -Path .\users.csv -UpnColumn 1 -FilterColumn 2 -FilterColumnValue "Finance" -WhatIf
        Test what would happen if you enabled the users with a value of Finance in the third column.
    .EXAMPLE
        Enable-SpanningUsersfromCSVAdvanced -Path .\users.csv -UpnColumn 0 -WhatIf
        Process all entries in the CSV file and show the accounts that could be processed.
    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Disable-SpanningUsersfromCSVAdvanced
    .LINK
        GitHub Repository: https://github.com/spanningcloudapps
    #>
    [CmdletBinding(SupportsShouldProcess=$true,
        DefaultParametersetName='None')]
    param(
        [Parameter(Position=0,Mandatory=$false,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        $AuthInfo,#The AuthInfo result from Get-SpanningAuthentication. If not provided the Script variable will be checked. If null you will be prompted.
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Path,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]#Column index containing the Use Principal Name
        [Int]$UpnColumn,
        [Parameter(ParameterSetName='Filter',
            Mandatory = $false)]#Column index of the column to filter on
        [Int]$FilterColumn,
        [Parameter(ParameterSetName='Filter',
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]#Filter string to apply to filter column for comparison
        [String]$FilterColumnValue
    )
    #TODO : Filter by column name rather than index
    # get column headers because this is one of those areas that Powershell makes life unnecessarily difficult
    $csvColumnNames = (Get-Content $Path | Select-Object -First 1).Split(",")
    $seek_column = $csvColumnNames[$FilterColumn] -replace '"', ""
    $source_column = $csvColumnNames[$UpnColumn] -replace '"', ""

    #import the CSV file
    $whole_csv = Import-CSV -path $Path

    #import only the matching rows if the filter is set
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

    # import users list so we can validate
    $existing_list = Get-SpanningUsers

    # get list of assigned users so we can do a delta
    $assigned_users = Get-SpanningAssignedUsers

    # and now we can start doing things with it

    Write-Verbose "$($whole_csv.count) rows in CSV"
    Write-Verbose "$($match_csv.count) matches in CSV"
    Write-Verbose "$($assigned_users.count) Spanning users currently assigned"
    Write-Verbose "Processing..."

    #$enableCount = 0
    $userList = [System.Collections.ArrayList]@()
    # begin looping through the matched CSV
    foreach ($user in $match_csv) {

        #Assign UPN in designated column
        $UserPrincipalName = $user.$source_column
        Write-Verbose "Processing $($UserPrincipalName)"

        #Validate against existing users so we don't throw an error
        if ($existing_list.userPrincipalName -notcontains $UserPrincipalName) {
            Write-Verbose "User $($UserPrincipalName) was not found in list. Proceeding to next user"
            continue
        }

        #once validated, we can actually add the user to be processed
        Write-Verbose "Adding user $UserPrincipalName to list"
        $userList.Add($UserPrincipalName) | Out-Null
    }

    #Break List into batches of 500
    $group = 500
    $i = 0
    $userBatch = @()
    $results = @()
    do {
        #Send the batch of Users 500 at a time.
        $userBatch = $userList[$i..(($i+= $group) - 1)]
        if ($pscmdlet.ShouldProcess("Processing $($userBatch.Count) users", "Enable-SpanningUserList")){
            $resultsBatch = Enable-SpanningUserList -AuthInfo $AuthInfo -UserPrincipalNames $userBatch

            #Need to join the results
            $results += $resultsBatch
        }
    }
    until ($i -gt $userList.count -1)

    # Write the combined output
    Write-Output $results

    Write-Verbose "Processing for users complete"

    if ($pscmdlet.ShouldProcess("Count of users to enable $($userList.Count)")){
        $updated_users = Get-SpanningAssignedUsers
        Write-Verbose "$($updated_users.count) Users are now enabled for Spanning"
    }

}

