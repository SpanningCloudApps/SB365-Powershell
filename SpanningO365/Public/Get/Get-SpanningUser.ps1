function Get-SpanningUser {
    <#
    .SYNOPSIS
        Returns the user information information from the Spanning Backup Portal
    .DESCRIPTION
        Returns the user license information from the Spanning Backup Portal for the supplied user principal name.
        If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER UserPrincipalName
        This parameter is the UPN of the user to disable.
    .PARAMETER UserType
        This parameter filters to specific user types from the set All, Admins, NonAdmins, Assigned, Unassigned, Deleted (from Active Directory), NotDeleted.
    .PARAMETER Size
        This parameter takes a page size parameter for the request. It defaults to 1000.
    .EXAMPLE
        Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .EXAMPLE
        Get-SpanningUser -UserType Admins
        Return only Admin Users
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
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
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Single User")]
        [ValidateNotNullOrEmpty()]
        #User Principal Name (email address) of the user to return.
        [string]$UserPrincipalName,
        [Parameter(
            Position=2,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Multiple Users")
        ]
        [ValidateSet('All','Admins','NonAdmins','Assigned','Unassigned','Deleted','NotDeleted')]
        #User type to return
        [string]$UserType,
        [Parameter(
            Position=3,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Multiple Users")]
        [Int]
        #Request Size parameter for User requests, default 1000
        $Size = 1000
    )
    Write-Verbose "Get-SpanningUser"

    # UserType : All (users), Admins, NonAdmins, Assigned, Unassigned
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo
    }

    # #TODO : Clean this up
    if ($UserType){
        Write-Verbose "UserType: $($UserType) - Invoke-SpanningRequest"
        $temp_users = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -Size $Size
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
            Write-Output $temp_users | Where-Object {$_.isAdmin -ne "true"}
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
        Deleted
        {
            Write-Verbose 'UserType = Deleted'
            Write-Output $temp_users | Where-Object {$_.IsDeleted -eq "true"}
        }
        NotDeleted
        {
            Write-Verbose 'UserType = NotDeleted'
            Write-Output $temp_users | Where-Object {$_.IsDeleted -ne "true"}
        }
        default
        {
            Write-Verbose 'UserType = null'
            #$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName" -Headers $headers -Method GET | ConvertFrom-Json
            $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -UserPrincipalName $UserPrincipalName -Size $Size
            Write-Output $results
        }
    }


}

