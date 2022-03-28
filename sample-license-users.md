# License Users with an Office 365 License

## Summary

If you have not reviewed the information in the [Usage Examples](samples.md) then you should start there to learn how to authenticate to the Spanning Backup API. Applying a Spanning License to all licensed users involves the following steps:

1. Connect to Office 365
1. Get a list of all Office 365 licensed users
1. Calculate the number of available Spanning licenses
1. Get a list of users that don't have a Spanning license
1. Compare the two lists to determine who needs a Spanning license
1. Test if you have enough licenses and offer an about
1. Apply the licenses (or as many as are available)
1. Optionally, report the remaining licenses

## Connect to Office 365

```powershell
$creds = Get-Credential -Message "O365" -UserName "ruby@doghousetoys.com"
Connect-MsolService -Credential $creds
```

## Get a list of all Office 365 licensed users

```powershell
$licensedO365Users = Get-MsolUser -All | where {$_.isLicensed -eq $true}
```

## Calculate the number of available Spanning licenses

```powershell
$token = "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33"
$admin = "ruby@doghousetoys.com"
$region = "US"
$auth = Get-SpanningAuthentication -ApiToken $token -Region $region -AdminEmail $admin

# Get the details of the tenant
$tenant = Get-SpanningTenantInfo
# Calculate the available licenses
$availableLicenses = $tenant.licenses - $tenant.assigned
```

## Get a list of users that don't have a Spanning license

```powershell
#List Unlicensed Users
$unlicensedUsers = Get-SpanningUser -UserType Unassigned
```

## Compare the two lists to determine who needs a Spanning license

```powershell
$usersToLicense = @()

$UserCount = $licensedO365Users.count
$i = 0
foreach ($user in $licensedO365Users){
    $i = $i + 1
    $pct = $i/$UserCount * 100
    Write-Progress -Activity "Checking Users" -Status "Processing Call QueueUSer $i of $UserCount - $($user.UserPrincipalName)" -PercentComplete $pct
    $userNeedsSpanning = $unlicensedUsers | where {$_.userPrincipalName -eq $user.UserPrincipalName}
    if ($userNeedsSpanning){
        $usersToLicense += $userNeedsSpanning
    }
}
Write-Progress -Activity "Checking Users" -Completed
```

## Test if you have enough licenses and offer an about

```powershell
$aborted = $false
# Test, do we have enough licenses
if ($availableLicenses -lt $usersToLicense.Count){
    Write-Warning "You do not have enough licenses to protect all unlicensed users."
    $aborted = $true
}
```

## Apply the licenses (or as many as are available)

```powershell
if (-not ($aborted)){
    if ($availableLicenses -gt 0){
        # Note the -WhatIf parameter, this is for testing the script. Remove it for production
        Enable-SpanningUserList -UserPrincipalNames $usersToLicense.userPrincipalName -WhatIf
    } else {
        Write-Warning "You are out of licenses"
        break
    }

} else {
    Write-Warning "Process Aborted"
}
```

## Optionally, report the remaining licenses

```powershell
# Get the details of the tenant
$tenant = Get-SpanningTenantInfo
# Calculate the available licenses
$availableLicenses = $tenant.licenses - $tenant.assigned
Write-Output "You have $($availableLicenses) licenses remaining."
```
