#############################################################################
# PowerShell Module for accessing the Spanning Backup for Office 365 REST API
# Version 3.0
# Copyright 2018 - Spanning Cloud Apps, LLC
#
# This Powershell Module is open sourced under Apache 2.0
# and IS NOT officially supported by Spanning Cloud Apps.
#############################################################################

<#
.Synopsis
  Get-SpanningAuthentication creates the Spanning Auth Header needed for making all Spanning API calls.
.DESCRIPTION
  All cmdlets in this module use the AuthInfo returned by this cmdlet. If you omit the AuthInfo parameter the 
  script level variables are checked and, if null, a call s made to Get-SpanningAuthentication.
.EXAMPLE
  Get-SpanningAuthentication
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail.
.EXAMPLE
  Get-SpanningAuthentication -ApiToken "your api token" -Region "US" -AdminEmail "admin@mydomain.com"
  Supply the three parameters on the command line.
.EXAMPLE
  $myApiToken = "your api token"
  $myAdminEmail = "admin@mytenant.onmicrosoft.com"
  $myRegion = "US"
  Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail
  Supply the three parameters from variables.
.EXAMPLE
  Get-SpanningAuthentication | Get-SpanningTenantInfo
  Pipe the results of Get-SpanningAuthentication to Get-SpanningInfo. 
.NOTES
  The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Clear-SpanningAuthentication
.LINK
  GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningAuthentication {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [String]$ApiToken,
        [Parameter(
            Position=1, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [ValidateSet('US','EU','AP')]
        [String]$Region,
        [Parameter(
            Position=2, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [String]$AdminEmail
    )
    
    Write-Verbose "Get-SpanningAuthentication..."  
    Write-Verbose "Session ApiToken: $($Script:ApiToken)"
    #Check the ApiToken
    if (!$Script:ApiToken -and !$ApiToken) {
        $ApiToken = Read-Host 'Enter Api Token'
        # Alternatively
        # throw [System.ArgumentException]'You must supply an API Token value'
    }
    if ($ApiToken) {
        $Script:ApiToken = $ApiToken
    }
    #Check the Region    
    if (!$Script:Region -and !$Region) {
        $Region = Read-Host 'Enter Spanning Region (US, EU or AP)'
        # Alternatively
        # throw [System.ArgumentException]'You must supply a Region value'
    }
    if ($Region) {
        $Script:Region = $Region
    }
    
    #Check AdminEmail
    if (!$Script:AdminEmail -and !$AdminEmail) {
        $AdminEmail = Read-Host 'Enter Admin Email Address'
        # Alternatively
        # throw [System.ArgumentException]'You must supply a Admin Email value'
    }
    if ($AdminEmail) {
        $Script:AdminEmail = $AdminEmail
    }

    $pair = "$($AdminEmail):$($ApiToken)"
    $Script:Pair = $pair
    
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $basicAuthValue = "Basic $base64"
    $headers = @{ Authorization = $basicAuthValue }

    #Create the AuthInfo Object
    $AuthInfo = New-Object -TypeName PSCustomObject
    $AuthInfo  | Add-Member -MemberType NoteProperty -Name Headers -Value ($headers) -PassThru | Add-Member -MemberType NoteProperty -Name Region -Value ($Region) 
    $Script:AuthInfo = $AuthInfo

    Write-Output $AuthInfo
}

<#
.Synopsis
   A utility function, not meant to be called directly. 
#>
function Get-AuthInfo{
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-AuthInfo"
    if (!$AuthInfo) {
        Write-Verbose "Get-AuthInfo: AuthInfo is null"
        if ($Script:AuthInfo)
        {
            Write-Verbose "Get-AuthInfo with AuthInfo from SessionState"
            $AuthInfo = $Script:AuthInfo
        } else  {
            Write-Verbose "Get-AuthInfo with the AuthInfo from Get-SpanningAuthentication"
            $AuthInfo = Get-SpanningAuthentication
        }
    }
    Write-Verbose "Get-AuthInfo with the returns this AuthInfo"
    if ($AuthInfo){
        Write-Verbose "Headers.Authorization: $($AuthInfo.Headers.Authorization)"
        Write-Verbose "Region $($AuthInfo.Region)"  
    } else {
        Write-Verbose "Error: AuthInfo is null."
    } 

    Write-Output $AuthInfo
}

<#
.Synopsis
  Clears the session Authentication variables
.DESCRIPTION
  Clears all script level session variables associated with authentication. 
  This cmdlet is useful when switching bewteen environments requireing different API Tokens.
  
.EXAMPLE
  Clear-SpanningAuthentication
  Clear the session ApiToken, Region, and AdminEmail variables.
.NOTES
   The variables are populated by the Get-SpanningAuthentication cmdlet.
.LINK
    Get-SpanningAuthentication
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Clear-SpanningAuthentication {
    [CmdletBinding()]
    param()
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'Region'  
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'ApiToken'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'AdminEmail'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'Pair'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'AuthInfo'
}

<#
.Synopsis
  Returns the tenant information from the Spanning Backup Portal
.DESCRIPTION
  Returns the tenant information from the Spanning Backup Portal for the supplied ApiToken, Region, and AdminEmail address
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
function Get-SpanningTenantInfo {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningTenantInfo"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo 
    }

    #$headers = $info[0]
    $headers = $AuthInfo.Headers
    #$region = $info[1]
    $region = $AuthInfo.Region
    $request = "https://o365-api-$region.spanningbackup.com/tenant"
    # $request
    $results = Invoke-WebRequest -uri $request -Headers $headers | ConvertFrom-Json
    Write-Output $results
}

<#
.Synopsis
  Get the current payment status from the Spanning Portal
.DESCRIPTION
  Get the current payment status from the Spanning Portal. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningTenantInfoPaymentStatus 
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningTenantInfo
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningTenantInfoPaymentStatus {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningTenantInfoPaymentStatus"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo 
    }

    #Simplified call to use Get-SpanningTenantInfo
    Write-Output $(Get-SpanningTenantInfo -AuthInfo $AuthInfo).status
}

<#
.Synopsis
  Apply a license to a user account
.DESCRIPTION
  Apply a license to the UserPrincipalName.
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Enable-SpanningUser -UserPrincipalName user@domain.com 
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
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
function Enable-SpanningUser {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo,

        [Parameter(
            Position=1,
            Mandatory = $true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String]
        $UserPrincipalName
    )
    Write-Verbose "Enable-SpanningUser"

    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo 
    }
    #$headers = $info[0]
    $headers = $AuthInfo.Headers   
    #$region = $info[1]
    $region = $AuthInfo.Region
    if ($pscmdlet.ShouldProcess("$UserPrincipalName", "Enable-SpanningUser")){
        #Actually do the work
        Write-Verbose "Assigning license to $($UserPrincipalName)"
        $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName/assign" -Headers $headers -Method POST | ConvertFrom-Json
        Write-Output $results
    }
}

<#
.Synopsis
  Removes the user license from a licensed user
.DESCRIPTION
  Removes the user license asignment from the Spanning Backup Portal for the supplied user principal name. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

.EXAMPLE
  Disable-SpanningUser -UserPrincipalName user@domain.com
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Enable-SpanningUser
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Disable-SpanningUser {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo,

        [Parameter(
            Position=1,
            Mandatory = $true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String]
        $UserPrincipalName
    )
    Write-Verbose "Disable-SpanningUser"
    
    if (!$AuthInfo) {
       Write-Verbose "No AuthInfo provided, checking Session State"
       $AuthInfo = Get-AuthInfo 
    }
    #$headers = $info[0]
    $headers = $AuthInfo.Headers   
    #$region = $info[1]
    $region = $AuthInfo.Region
    
    if ($pscmdlet.ShouldProcess("$UserPrincipalName", "Disable-SpanningUser")){
        #Actually do the work
        Write-Verbose "Disable license for $($UserPrincipalName)"
        $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName/unassign" -Headers $headers -Method POST | ConvertFrom-Json
        Write-Output $results
    }
}

<#
.Synopsis
  Returns the user information information from the Spanning Backup Portal
.DESCRIPTION
  Returns the user license information from the Spanning Backup Portal for the supplied user principal name. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

.EXAMPLE
  Get-SpanningUser -UserPrincipalName
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
function Get-SpanningUser {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo,

        [Parameter(
            Position=1,
            Mandatory = $true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Single User")]
        [String]
        $UserPrincipalName,
        [Parameter(
            Position=2, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            ParameterSetName = "Get Multiple Users")
        ]
        [ValidateSet('All','Admins','NonAdmins','Assigned','Unassigned')]
        [String]$UserType
    )
    Write-Verbose "Get-SpanningUser"

    # UserType : All (users), Admins, NonAdmins, Assigned, Unassigned 
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo 
     }
 
    #$headers = $info[0]
    $headers = $AuthInfo.Headers
    #$region = $info[1]
    $region = $AuthInfo.Region

    #TODO : Clean this up
    if ($UserType){
        $values2 = @()
        $values = @()
        $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users" -Headers $headers -Method GET | ConvertFrom-Json
        $values2 = $values2 + $results.users
        DO {
            $results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
            $values = $values + $results.users
        } Until ($results.nextlink.Length -eq 0)
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
            Write-Output $temp_users | where {$_.isAdmin -eq "true"}
        }
        NonAdmins
        {
            Write-Verbose 'UserType = NonAdmins'
            $temp_users | where {$_.isAdmin -ne "true"}
        }
        Assigned
        {
            Write-Verbose 'UserType = Assigned'
            Write-Output $temp_users | where {$_.Assigned -eq "true"}
        }
        Unassigned
        {
            Write-Verbose 'UserType = Unassigned'
            Write-Output $temp_users | where {$_.Assigned -ne "true"}
        }
        default
        {
            Write-Verbose 'UserType = null'
            $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$UserPrincipalName" -Headers $headers -Method GET | ConvertFrom-Json
            Write-Output $results
        }
    }

}

<#
.Synopsis
  Returns the user license information for all users from the Spanning Backup Portal
.DESCRIPTION
  Returns the user license information from the Spanning Backup Portal for all Spanning Users. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningUsers 
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningUser -UserType All
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningUsers {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningUsers"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo 
     }
     
     Write-Output $(Get-SpanningUser -AuthInfo $AuthInfo -UserType All)
}

<#
.Synopsis
  Returns the admin users from the Spanning Backup Portal
.DESCRIPTION
  Returns the admin users information from the Spanning Backup Portal. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningAdmins
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningUser -UserType Admins
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningAdmins {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningAdmins"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo 
     }
     
     Write-Output $(Get-SpanningUser -AuthInfo $AuthInfo -UserType Admins)
}

<#
.Synopsis
  Returns the non-admin users from the Spanning Backup Portal
.DESCRIPTION
  Returns the non-admin users information from the Spanning Backup Portal. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningNonAdmins 
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningUser -UserType NonAdmins
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningNonAdmins {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningNonAdmins"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo 
     }
     
     Write-Output $(Get-SpanningUser -AuthInfo $AuthInfo -UserType NonAdmins)
}

<#
.Synopsis
  Returns the assigned users from the Spanning Backup Portal
.DESCRIPTION
  Returns the assigned users information from the Spanning Backup Portal. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningAssignedUsers 
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningUser -UserType Assigned    
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningAssignedUsers {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningAssignedUsers"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo 
     }
     
     Write-Output $(Get-SpanningUser -AuthInfo $AuthInfo -UserType Assigned)
}

<#
.Synopsis
  Returns the unassigned users from the Spanning Backup Portal
.DESCRIPTION
  Returns the unassigned users information from the Spanning Backup Portal. 
  If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
.EXAMPLE
  Get-SpanningUnassignedUsers 
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
.LINK
    Get-SpanningAuthentication
.LINK
    Get-SpanningUser -UserType Unassigned
.LINK
    GitHub Repository: https://github.com/spanningcloudapps
#>
function Get-SpanningUnassignedUsers {
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0, 
            Mandatory=$false, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        $AuthInfo
    )
    Write-Verbose "Get-SpanningUnassignedUsers"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo 
     }
     
     Write-Output $(Get-SpanningUser -AuthInfo $AuthInfo -UserType Unassigned)
}

function Enable-SpanningUsersfromCSVAdvanced {
    param(
        [parameter(Mandatory = $true)]
        [String]$path_to_csv,
        [parameter(mandatory = $true)]
        [Int]$column,
        [parameter(mandatory = $true)]
        [Int]$column_match,
        [parameter(mandatory = $true)]
        [String]$column_value
    )
    # get column headers because this is one of those areas that Powershell makes life unnecessarily difficult
    $csvColumnNames = (Get-Content $path_to_csv | Select-Object -First 1).Split(",")
    $seek_column = $csvColumnNames[$column_match] -replace '"', ""
    $source_column = $csvColumnNames[$column] -replace '"', ""

    #import the CSV file
    $whole_csv = Import-CSV -path $path_to_csv

    #import only the matching rows
    $match_csv = Import-CSV -path $path_to_csv |where-object {$_.$seek_column -eq $column_value}

    # import users list so we can validate
    $existing_list = Get-SpanningUsers

    # get list of assigned users so we can do a delta
    $assigned_users = Get-SpanningAssignedUsers

    # and now we can start doing things with it

    Write-Host $whole_csv.count "rows in CSV"
    Write-Host $match_csv.count "matches in CSV"
    Write-Host $assigned_users.count "Spanning users currently assigned"
    Write-Host "Processing"

    # begin looping through the matched CSV
    ForEach ($i in $match_csv) {
        $i

        #assign UPN in designated column
        $UserPrincipalName = $i.$source_column
        write-host "processing" $userprincipalname

        #validate against existing users so we don't throw an error
        if ($existing_list.userPrincipalName -notcontains $userPrincipalName -eq "True") {
            Write-Host "User" $UPN "was not found in list. Proceeding to next user"
            continue
        }

        #once validated, we can actually execute the enable command

        $info = Get-SpanningAuthentication
        $headers = $info[0]
        $region = $info[1]
        $uri = "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/assign"
        $uri
        $results = Invoke-WebRequest -uri $uri -Headers $headers -Method POST | ConvertFrom-Json
        Write-host "Processing for user complete"
        $results
    }
    $updated_users = Get-SpanningAssignedUsers
    Write-Host $updated_users.count "Users are now enabled for Spanning"

}


function Disable-SpanningUsersfromCSVAdvanced {
    param(
        [parameter(Mandatory = $true)]
        [String]$path_to_csv,
        [parameter(mandatory = $true)]
        [Int]$column,
        [parameter(mandatory = $true)]
        [Int]$column_match,
        [parameter(mandatory = $true)]
        [String]$column_value
    )
    # get column headers because this is one of those areas that Powershell makes life unnecessarily difficult
    $csvColumnNames = (Get-Content $path_to_csv | Select-Object -First 1).Split(",")
    $seek_column = $csvColumnNames[$column_match] -replace '"', ""
    $source_column = $csvColumnNames[$column] -replace '"', ""

    #import the CSV file
    $whole_csv = Import-CSV -path $path_to_csv

    #import only the matching rows
    $match_csv = Import-CSV -path $path_to_csv |where-object {$_.$seek_column -eq $column_value}

    # import users list so we can validate
    $existing_list = Get-SpanningUsers

    # get list of assigned users so we can do a delta
    $assigned_users = Get-SpanningAssignedUsers

    # and now we can start doing things with it

    Write-Host $whole_csv.count "rows in CSV"
    Write-Host $match_csv.count "matches in CSV"
    Write-Host $assigned_users.count "Spanning users currently assigned"
    Write-Host "Processing"

    # begin looping through the matched CSV
    ForEach ($i in $match_csv) {
        $i

        #unassign UPN in designated column
        $UserPrincipalName = $i.$source_column
        write-host "processing" $userprincipalname

        #validate against existing users so we don't throw an error
        if ($existing_list.userPrincipalName -notcontains $userPrincipalName -eq "True") {
            Write-Host "User" $UPN "was not found in list. Proceeding to next user"
            continue
        }

        #once validated, we can actually execute the disable command

        $info = Get-SpanningAuthentication
        $headers = $info[0]
        $region = $info[1]
        $uri = "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/unassign"
        $uri
        $results = Invoke-WebRequest -uri $uri -Headers $headers -Method POST | ConvertFrom-Json
        Write-host "Processing for user complete"
        $results
    }
    $updated_users = Get-SpanningAssignedUsers
    Write-Host $updated_users.count "Users are now enabled for Spanning."

}
