﻿function Get-SpanningUser {

    [CmdletBinding()]
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
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Single User")]
        [ValidateNotNullOrEmpty]
        [String]
        #User Principal Name (email address) of the user to return.
        $UserPrincipalName,
        [Parameter(
            Position=2,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Multiple Users")
        ]
        [ValidateSet('All','Admins','NonAdmins','Assigned','Unassigned')]
        [String]
        #User type to return
        $UserType
    )
    Write-Verbose "Get-SpanningUser"

    # UserType : All (users), Admins, NonAdmins, Assigned, Unassigned
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo
     }

    #$headers = usernfo[0]
    $headers = $AuthInfo.Headers
    #$region = usernfo[1]
    $region = $AuthInfo.Region

    #TODO : Clean this up
    if ($UserType){
        $values2 = @()
        $values = @()
        $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users" -Headers $headers -Method GET | ConvertFrom-Json
        $values2 += $results.users
        do {
            $results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
            $values += $results.users
        } until ($results.nextlink.Length -eq 0)
        $values.count
        $values3 = $values2 + $values
        $temp_users = $values3
    }

    switch ( $UserType )
    {
        All
        {
            Write-Verbose 'UserType = All'
            Write-Output $temp_users
        }
        Admins
        {
            Write-Verbose 'UserType = Admins'
            Write-Output $temp_users | Where-Object {$_.isAdmin -eq "true"}
        }
        NonAdmins
        {
            Write-Verbose 'UserType = NonAdmins'
            $temp_users | Where-Object {$_.isAdmin -ne "true"}
        }
        Assigned
        {
            Write-Verbose 'UserType = Assigned'
            Write-Output $temp_users | Where-Object {$_.Assigned -eq "true"}
        }
        Unassigned
        {
            Write-Verbose 'UserType = Unassigned'
            Write-Output $temp_users | Where-Object {$_.Assigned -ne "true"}
        }
        default
        {
            Write-Verbose 'UserType = null'
            $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName" -Headers $headers -Method GET | ConvertFrom-Json
            Write-Output $results
        }
    }


}

