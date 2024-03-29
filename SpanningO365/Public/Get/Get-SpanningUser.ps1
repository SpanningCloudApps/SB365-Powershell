﻿function Get-SpanningUser {
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
    .PARAMETER Status
        This parameter takes an optional parameter to include the User Backup Status in the result.
        Note, this can significantly increase both the result size and the time required for PowerShell to process the results.
    .PARAMETER StartDate
        This parameter takes the Start Date for the user backup status report.
    .PARAMETER EndDate
        This parameter takes the End Date for the user backup status report. (This value is optional, and defaults to today.)
    .PARAMETER InAAD
        This parameter checks for the users that exist or do not exist in Azure Active Directory. The default is All users without respect to AAD status.
    .EXAMPLE
        Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .EXAMPLE
        Get-SpanningUser -UserType Admins
        Return only Admin Users
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .EXAMPLE
        Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com -Status $true
        Return the backup status for a single user.
    .EXAMPLE
        $user = Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com -Status $true -StartDate (Get-Date).AddDays(-5)
        $user.backupSummary
        Return the backup status for a single user beginning 5 days ago.
    .EXAMPLE
        $user = Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com -Status $true -StartDate (Get-Date).AddDays(-5) -EndDate (Get-Date).AddDays(-1)
        $user.backupSummary
        Return the backup status for a single user beginning 5 days ago ending 1 day ago.
    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        GitHub Repository: https://github.com/spanningcloudapps
    #>
    [CmdletBinding()]
    [OutputType("System.Object[]",ParameterSetName = "Get Multiple Users")]
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
        $Size = 1000,
        [Parameter(
            Position=4,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [bool]
        #Include backup status for users $false by default
        $Status = $false,
        [Parameter(
            Position=5,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [ValidateSet('All','InAAD','NotInAAD')]
        [string]
        #Limit to users in or not in AAD
        $InAAD = 'All',
        [Parameter(
            Position=6,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #Starting date of the user backup summary query
        [datetime]$StartDate,
        [Parameter(
            Position=7,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        #Ending date of the user backup summary query
        [datetime]$EndDate
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
        #$temp_users = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -Size $Size -Status $Status

        if ($StartDate)
        {
            if ($EndDate)
            {
                # Tenant Backup Summary Request with Start and End
                $temp_users = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -Size $Size -Status $Status  -StartDate $StartDate -EndDate $EndDate -InAAD $InAAD
            }
            else {
                # Tenant Backup Summary Request with Start only
                $temp_users = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -Size $Size -Status $Status -StartDate $StartDate -InAAD $InAAD
            }
        }
        else {
            # Tenant Backup Summary Request
            $temp_users = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -Size $Size -Status $Status -InAAD $InAAD
        }
    }

    switch ( $UserType )
    {
        All
        {
            Write-Verbose 'UserType = All'
            [array]$returnUsers = $temp_users
            return ,$returnUsers
        }
        Admins
        {
            Write-Verbose 'UserType = Admins'
            [array]$returnUsers = $temp_users | Where-Object {$_.isAdmin -eq "true"}
            return ,$returnUsers
        }
        NonAdmins
        {
            Write-Verbose 'UserType = NonAdmins'
            [array]$returnUsers = $temp_users | Where-Object {$_.isAdmin -ne "true"}
            return ,$returnUsers
        }
        Assigned
        {
            Write-Verbose 'UserType = Assigned'
            [array]$returnUsers = $temp_users | Where-Object {$_.Assigned -eq "true"}
            return ,$returnUsers
        }
        Unassigned
        {
            Write-Verbose 'UserType = Unassigned'
            [array]$returnUsers = $temp_users | Where-Object {$_.Assigned -ne "true"}
            return ,$returnUsers
        }
        Deleted
        {
            Write-Verbose 'UserType = Deleted'
            [array]$returnUsers = $temp_users | Where-Object {$_.IsDeleted -eq "true"}
            return ,$returnUsers
        }
        NotDeleted
        {
            Write-Verbose 'UserType = NotDeleted'
            [array]$returnUsers = $temp_users | Where-Object {$_.IsDeleted -ne "true"}
            return ,$returnUsers
        }
        default
        {
            Write-Verbose 'UserType = null'
            # Return the User
            #$results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -UserPrincipalName $UserPrincipalName -Size $Size -Status $Status -InAAD $InAAD
            if ($StartDate)
            {
                if ($EndDate)
                {
                    # Tenant Backup Summary Request with Start and End
                    $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -UserPrincipalName $UserPrincipalName -Size $Size -Status $Status -InAAD $InAAD -StartDate $StartDate -EndDate $EndDate
                }
                else {
                    # Tenant Backup Summary Request with Start only
                    $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -UserPrincipalName $UserPrincipalName -Size $Size -Status $Status -InAAD $InAAD -StartDate $StartDate
                }
            }
            else {
                # Tenant Backup Summary Request
                $results = Invoke-SpanningRequest -AuthInfo $AuthInfo -RequestType User -UserPrincipalName $UserPrincipalName -Size $Size -Status $Status -InAAD $InAAD
            }
            Write-Output $results
        }
    }


}

