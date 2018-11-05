#############################################################################
# PowerShell Module for accessing the Spanning Backup for Office 365 REST API
# Version 3.0
# Copyright 2018 - Spanning Cloud Apps, LLC
#
# This Powershell Module is open sourced under Apache 2.0
# and IS NOT officially supported by Spanning Cloud Apps.
#############################################################################

#$global:region = ""
#$global:apitoken = ""
#$global:adminid = ""

<#
.Synopsis
  Get-SpanningAuthentication creates the Spanning Auth Header needed for making all Spanning API calls.
.DESCRIPTION
  Matt - Add a long description about how the call loads the script level variables.
.EXAMPLE
  Get-SpanningAuthentication
  Without any parameters you will be prompted for ApiToken, Region, and AdminEmail.
.EXAMPLE
  $myApiToken = "your api token"
  $myAdminEmail = "admin@mytenant.onmicrosoft.com"
  $myRegion = "US"

  Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail

  Supply the three parameters from variables.
.EXAMPLE
  Get-SpanningAuthentication -ApiToken "your api token" -Region "US" -AdminEmail "admin@mydomain.com"

  Supply the three parameters on the command line.
.NOTES
   The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
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
    if (!$Script:ApiToken -and !$ApiToken) {
        $ApiToken = Read-Host 'Enter Api Token'
        # Alternatively
        # throw [System.ArgumentException]'You must supply an API Token value'
    }
    if ($ApiToken) {
        $Script:ApiToken = $ApiToken
    }
    #$myApiToken = $Script:ApiToken
    #Write-Host "Spanning Api Token: $($myApiToken)"

    #if (($global:apitoken -eq "") -or ($ApiToken -eq "")) {
    #    $global:apitoken = Read-Host 'Enter Spanning API Key'
    #}
    
    if (!$Script:Region -and !$Region) {
        $Region = Read-Host 'Enter Spanning Region (US, EU or AP)'
        # Alternatively
        # throw [System.ArgumentException]'You must supply a Region value'
    }
    if ($Region) {
        $Script:Region = $Region
    }
    #$myRegion = $Script:Region
    #Write-Host "Spanning Region: $($myRegion)"

#    if ($global:region -eq "") {
#        $global:region = Read-Host 'Enter Spanning Region (US, EU or AP)'
#    }

    if (!$Script:AdminEmail -and !$AdminEmail) {
        $AdminEmail = Read-Host 'Enter Admin Email Address'
        # Alternatively
        # throw [System.ArgumentException]'You must supply a Admin Email value'
    }
    if ($AdminEmail) {
        $Script:AdminEmail = $AdminEmail
    }
#    $myAdminEmail = $Script:AdminEmail
#    Write-Host "Spanning Admin Email: $($myAdminEmail)"

#    if ($global:adminid -eq "") {
#        $global:adminid = Read-Host 'Enter Admin Email Address'
#    }

    #$global:user = $adminid
    #$global:pass = $apitoken
    #$global:pair = "${user}:${pass}"
    $pair = "$($AdminEmail):$($ApiToken)"
    $Script:Pair = $pair
    
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $basicAuthValue = "Basic $base64"
    $headers = @{ Authorization = $basicAuthValue }
    #$array2 = $headers, $global:region
    #$array2 = $headers, $Region
    
    #return $array2
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
        Write-Verbose "AuthInfo is null"
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
    #$global:region = ""
    #$global:apitoken = ""
    #$global:adminid = ""
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
    #$info = Get-SpanningAuthentication
    #  if (!$AuthInfo) {
    #      if ($Script:AuthInfo)
    #      {
    #          Write-Verbose "Get-SpanningTenantInfo with AuthInfo from SessionState"
    #          $AuthInfo = $Script:AuthInfo
    #      } else  {
    #          Write-Verbose "Get-SpanningTenantInfo with the AuthInfo from Get-SpanningAuthentication"
    #          $AuthInfo = Get-SpanningAuthentication
    #      }
    #  }
    #  Write-Verbose "Get-SpanningTenantInfo with the following AuthInfo"
    #  if ($AuthInfo){
    #      Write-Verbose "Headers.Authorization: $($AuthInfo.Headers.Authorization)"
    #      Write-Verbose "Region $($AuthInfo.Region)"  
    #  } else {
    #      Write-Verbose "AuthInfo is null"
    #  } 

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

function Get-SpanningTenantInfoPaymentStatus {
    param(
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
    $request = "https://o365-api-$region.spanningbackup.com/tenant"
    #$request
    $results = Invoke-WebRequest -uri $request -Headers $headers | ConvertFrom-Json
    $results.status
}

function Enable-SpanningUser {
    param(
        [parameter(Mandatory = $true)]
        [String]
        $userPrincipalName
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
    $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/assign" -Headers $headers -Method POST | ConvertFrom-Json
    $results
}

function Disable-SpanningUser {
    param(
        [parameter(Mandatory = $true)]
        [String]
        $userPrincipalName
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
    $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/unassign" -Headers $headers -Method POST | ConvertFrom-Json
    $results
}

function Get-SpanningUsers {
    param(
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
    $values2 = @()
    $values = @()
    $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users?size=1000" -Headers $headers -Method GET | ConvertFrom-Json
    $values2 = $values2 + $results.users
    DO {
        $results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
        $values = $values + $results.users
    } Until ($results.nextlink.Length -eq 0)
    $values3 = $values2 + $values
    $values3
}

function Get-SpanningUser {
    param(
        [parameter(Mandatory = $true)]
        [String]
        $userPrincipalName
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
    $results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName" -Headers $headers -Method GET | ConvertFrom-Json
    $results
}

function Get-SpanningAdmins {
    param(
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
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
    $temp_users | where {$_.isAdmin -eq "true"}
}


function Get-SpanningNonAdmins {
    param(
    )
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
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
    $temp_users | where {$_.isAdmin -ne "true"}
}



function Get-SpanningAssignedUsers {
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
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
    $temp_users | where {$_.Assigned -eq "true"}
}

function Get-SpanningUnassignedUsers {
    $info = Get-SpanningAuthentication
    $headers = $info[0]
    $region = $info[1]
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
    $temp_users | where {$_.Assigned -ne "true"}
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
