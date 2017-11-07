#####################################################################
# Spanning Backup For Office 365 PowerShell Module
# Version 1.0
# Author Ryan Crompton
# Copyright 2016
#####################################################################

$global:region=""                                                                                                                         
$global:apitoken = ""                                                                                             
$global:adminid = ""

function Get-SpanningAuthentication{
param(
)
if ($global:apitoken -eq "")
{
$global:apitoken = Read-Host 'Enter Spanning API Key'
}
if ($global:region -eq "")
{
$global:region = Read-Host 'Enter Spanning Region (EU or US)'
}
if ($global:adminid -eq "")
{
$global:adminid = Read-Host 'Enter Admin Email Address'
}
$global:user = $adminid
$global:pass = $apitoken
$global:pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }
$array2 = $headers,$global:region
return $array2
}

function Clear-SpanningAuthentication{
$global:region=""                                                                                                                         
$global:apitoken = ""                                                                                             
$global:adminid = ""
}

function Get-TenantInfo{
param(
)
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$request = "https://o365-api-$region.spanningbackup.com/tenant"
# $request
$results = Invoke-WebRequest -uri $request -Headers $headers | ConvertFrom-Json
$results
}

function Get-TenantInfoPaymentStatus{
param(
)
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$request = "https://o365-api-$region.spanningbackup.com/tenant"
#$request
$results = Invoke-WebRequest -uri $request -Headers $headers | ConvertFrom-Json
$results.status
}

function Enable-SpanningUser{
param(
	[parameter(Mandatory=$true)]
	[String]
	$userPrincipalName
) 
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/assign" -Headers $headers -Method POST | ConvertFrom-Json
$results
}

function Disable-SpanningUser{
param(
	[parameter(Mandatory=$true)]
	[String]
	$userPrincipalName
) 
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/unassign" -Headers $headers -Method POST | ConvertFrom-Json
$results
}

function Get-SpanningUsers{
param(
) 
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$values2 = @()
$values = @()
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users?size=1000" -Headers $headers -Method GET | ConvertFrom-Json
$values2 = $values2+$results.users
DO
{
$results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
$values=$values+$results.users
} Until ($results.nextlink.Length -eq 0)
$values3=$values2+$values
$values3
}

function Get-SpanningUser{
param(
	[parameter(Mandatory=$true)]
	[String]
	$userPrincipalName
)	
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/user/$userPrincipalName" -Headers $headers -Method GET | ConvertFrom-Json
$results
}

function Get-SpanningAdmins{
param(
) 
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$values2 = @()
$values = @()
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users?size=1000" -Headers $headers -Method GET | ConvertFrom-Json
$values2 = $values2+$results.users
DO
{
$results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
$values=$values+$results.users
} Until ($results.nextlink.Length -eq 0)
$values3=$values2+$values
$temp_users = $values3
$temp_users | where {$_.isAdmin -eq "true"}
}


function Get-SpanningNonAdmins{
param(
) 
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$values2 = @()
$values = @()
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users?size=1000" -Headers $headers -Method GET | ConvertFrom-Json
$values2 = $values2+$results.users
DO
{
$results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
$values=$values+$results.users
} Until ($results.nextlink.Length -eq 0)
$values3=$values2+$values
$temp_users = $values3
$temp_users | where {$_.isAdmin -ne "true"}
}



function Get-SpanningAssignedUsers{
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$values2 = @()
$values = @()
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users?size=1000" -Headers $headers -Method GET | ConvertFrom-Json
$values2 = $values2+$results.users
DO
{
$results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
$values=$values+$results.users
} Until ($results.nextlink.Length -eq 0)
$values3=$values2+$values
$temp_users = $values3
$temp_users | where {$_.Assigned -eq "true"}
}

function Get-SpanningUnassignedUsers{
$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$values2 = @()
$values = @()
$results = Invoke-WebRequest -uri "https://o365-api-$region.spanningbackup.com/users?size=1000" -Headers $headers -Method GET | ConvertFrom-Json
$values2 = $values2+$results.users
DO
{
$results = Invoke-WebRequest -uri $results.nextLink -Headers $headers -Method GET | ConvertFrom-JSON
$values=$values+$results.users
} Until ($results.nextlink.Length -eq 0)
$values3=$values2+$values
$temp_users = $values3
$temp_users | where {$_.Assigned -ne "true"}
}

function Enable-SpanningUsersfromCSVAdvanced{
param(
	[parameter(Mandatory=$true)]
	[String]$path_to_csv,
    [parameter(mandatory=$true)]
    [Int]$column,
    [parameter(mandatory=$true)]
    [Int]$column_match,
    [parameter(mandatory=$true)]
    [String]$column_value
) 
# get column headers because this is one of those areas that Powershell makes life unnecessarily difficult
$csvColumnNames = (Get-Content $path_to_csv | Select-Object -First 1).Split(",")
$seek_column=$csvColumnNames[$column_match] -replace '"',""
$source_column=$csvColumnNames[$column] -replace '"',""

#import the CSV file
$whole_csv = Import-CSV -path $path_to_csv

#import only the matching rows
$match_csv = Import-CSV -path $path_to_csv |where-object {$_.$seek_column -eq $column_value}

# import users list so we can validate
$existing_list = Get-SpanningUsers

# get list of assigned users so we can do a delta
$assigned_users=Get-SpanningAssignedUsers

# and now we can start doing things with it

Write-Host $whole_csv.count "rows in CSV"
Write-Host $match_csv.count "matches in CSV"
Write-Host $assigned_users.count "Spanning users currently assigned"
Write-Host "Processing"

# begin looping through the matched CSV
ForEach ($i in $match_csv)
{
$i

#assign UPN in designated column
$UserPrincipalName=$i.$source_column
write-host "processing" $userprincipalname

#validate against existing users so we don't throw an error
if ($existing_list.userPrincipalName -notcontains $userPrincipalName -eq "True")
{Write-Host "User" $UPN "was not found in list. Proceeding to next user"
continue}

#once validated, we can actually execute the enable command

$info = Get-SpanningAuthentication
$headers=$info[0]
$region=$info[1]
$uri="https://o365-api-$region.spanningbackup.com/user/$userPrincipalName/assign"
$uri
$results = Invoke-WebRequest -uri $uri -Headers $headers -Method POST | ConvertFrom-Json
Write-host "Processing for user complete"
$results
}
$updated_users = Get-SpanningAssignedUsers
Write-Host $updated_users.count "Users are now enabled for Spanning"

}
