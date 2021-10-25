# Usage Examples

## Generate Spanning API key

In order to authenticate with the Spanning Backup for Office 365 API you need an API token.

1. Login to the Spanning Backup portal and click **Settings**.
1. In the **API Token** section click **Generate Token**. Note: if the button says **Revoke Token** a token has already been generated. You either need to revoke and regenerate the token or find out who has the token.
1. Record the API Token in a safe place. Once you navigate away from the page it will not be shown again.

Now that you have the API Token you only need to know your region and the email address of the administrator for executing the commands. (Your region was selected when you installed the app for the first time. You can determine your region from the URL of the portal:

- https<span></span>://o365-**us**.spanningbackup.com/ is the **US** Region for the United States
- https<span></span>://o365-**eu**.spanningbackup.com/ is the **EU** Region for Europe
- https<span></span>://o365-**ap**.spanningbackup.com/ is the **AP** Region for Australia/Pacific

```plaintext
For these examples we will use the following information:
- API Token: 2a4d91f3-dc91-46c5-bfa9-a6f0adefed33
- Region: US
- Admin Email: ruby@doghousetoys.com
```

## Authenticate with Get-SpanningAuthentication

The **Get-SpanningAuthentication** function creates the necessary authentication headers for calling the Spanning Backup API. If you call any other function without supplying the authentication information you will be prompted for the necessary information, so you might as well start here! While you could execute **Get-SpanningAuthentication** without any parameters and then fill in the prompts, the easiest way to start is to simply call the **Get-SpanningAuthentication** function with the necessary parameters for your tenant.

If you are using this module in Azure Automation Accounts you can use the **Connection** parameter to pass a connection hashtable for easier storage of your connection variables in Azure.

**Note:** These PowerShell samples are wrapped for clarity and use the backtick character "`" in the event you want to copy and paste them.

```powershell
Get-SpanningAuthentication -ApiToken "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33" `
    -Region "US" -AdminEmail "ruby@doghousetoys.com"
```

This does two things, it returns an **AuthInfo** object and stores the **AuthInfo** in a session variable. The benefit of the object is that you can use the PowerShell pipeline to send the AuthInfo to another Spanning function. For example to get a list of Administrators in one line you could execute:

```powershell
Get-SpanningAuthentication -ApiToken "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33" `
    -Region "US" -AdminEmail "ruby@doghousetoys.com" | Get-SpanningAdmins
```

Alternatively, you could store the **AuthInfo** in a variable and reuse it:

```powershell
$myAuthinfo = Get-SpanningAuthentication -ApiToken "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33" `
    -Region "US" -AdminEmail "ruby@doghousetoys.com"

Get-SpanningAdmins -AuthInfo $myAuthinfo
```

It's really up to you, you have the flexibility to use the Authentication the way that suits you best. If you need to switch contexts you can clear out the stored **AuthInfo** with the **Clear-SpanningAuthentication** function.

```powershell
Clear-SpanningAuthentication
```

## Listing Users

You can list the different users from the Spanning Portal with the **Get-SpanningUser** function. This function can take either a specific UPN for a user or a user type enumeration of:

- All: All users in the Spanning portal
- Admins: Users assigned to the Admin Role
- NonAdmins: Users who are not administrators
- Assigned: Users assigned a Spanning Backup for Office 365 license
- Unassigned: Users who are not assigned a Spanning Backup for Office 365 license
- Deleted: Users deleted from Azure AD and present in Spanning Backup for Office 365
- NotDeleted: Users who are active in Azure AD and present in Spanning Backup for Office 365

To retrieve the status of a single user "ruby@doghousetoys.com":

```powershell
Get-SpanningUser -UserPrincipalName "ruby@doghousetoys.com"
```

To determine the currently assigned Administrators:

```powershell
Get-SpanningUser -UserType Admins
```

For backwards compatibility to the previous version of the module you can still explicitly call the following functions and retrieve the associated users:

```powershell
Get-SpanningAdmins
```

```powershell
Get-SpanningNonAdmins
```

```powershell
Get-SpanningAssignedUsers
```

```powershell
Get-SpanningUnassignedUsers
```

```powershell
Get-SpanningUsers
```

## Get Tenant Information

You can use PowerShell to determine the status of your Spanning tenant and current payment status. The **Get-SpanningTenantInfo** function returns the number of licenses, users, assignments, and payment status. The **Get-SpanningTenantPaymentInfo** returns only the payment status.

```powershell
Get-SpanningTenantInfo
```

Will return a status like this:

```plaintext
licenses users assigned status
-------- ----- -------- ------
100      106   9        trial
```

```powershell
Get-SpanningTenantInfoPaymentStatus
```

Will only return the payment status:

```plaintext
trial
```

## Enabling Users

Users are enabled or licensed for Spanning Backup for Office 365 using the **Enable-SpanningUserList** function. This function takes an array of UserPrincipalNames and applies a Spanning license to the user or users. Once enabled, the user will be included in the next scheduled backup. The **Enable-SpanningUserList** function accepts input from the pipeline and can be included in more complex user and group queries if necessary. See the [Advanced Use Cases](#advanced) section later in this article.

```powershell
$users = "cheyenne@doghousetoys.com","ruby@doghousetoys.com"
Enable-SpanningUserList -UserPrincipalNames $users
```

If you have a comma separated value file and want to use it for bulk licensing you can use the **Enable-SpanningUsersFromCSVAdvanced** function. If your CSV file is formatted as follows:

```plaintext
Name,UPN,Department,Geography
Willa,willa@doghousetoys.com,Finance,US
Kobe,kobe@doghousetoys.com,Sales,EU
Jazzy,jazzy@doghousetoys.com,Finance,EU
Cheyenne,cheyenne@doghousetoys.com,Finance,US
```

You have two options depending on how you wish to license your users. You can apply licenses to all users by referencing the path to the file and the UPN Column of 1 (CSV uses a zero based index for columns) and by omitting the user filter:

```powershell
Enable-SpanningUsersFromCSVAdvanced -Path "C:\Test\Users.csv" -UpnColumn 1
```

The result should be displayed as follows:

```plaintext
userPrincipalName          licensed
-------------------------  --------
willa@doghousetoys.com     True
kobe@doghousetoys.com      True
jazzy@doghousetoys.com     True
cheyenne@doghousetoys.com  True
```

Another option is to use a filter to include only those users matching your filter criteria. For example if you only want to limit your licensing to the US Geography you could use the following filter:

```powershell
Enable-SpanningUsersFromCSVAdvanced  -Path "C:\Test\Users.csv" -UpnColumn 1 `
    -FilterColumn 3 -FilterColumnValue "US"
```

The result will be displayed as follows:

```plaintext
userPrincipalName          licensed
-------------------------  --------
willa@doghousetoys.com     True
cheyenne@doghousetoys.com  True
```

## Disabling Users

If you need to revoke a Spanning Backup for Office 365 license you can use the **Disable-SpanningUserList** function. This function requires an array of UPNs for the target user or users. You will be prompted to confirm the removal of the license as this will also delete the associated backups for the users in 30 days.

```powershell
$users = "kobe@doghousetoys.com","ruby@doghousetoys.com"
Disable-SpanningUserList -UserPrincipalNames $users
```

The result will confirm the license removal.

```plaintext
userPrincipalName                                licensed
-----------------                                --------
{kobe@doghousetoys.com,ruby@doghousetoys.com}      False
```

In the event you wish to remove licenses in bulk from a CSV file, you can use the **Disable-SpanningUsersFromCSVAdvanced** function or the alternatives in the [Advanced Use Cases](#advanced) section later in this article. Like it's counterpart **Enable-SpanningUsersFromCSVAdvanced** you can either disable all users listed in the CSV file or provide a filter column and filter value.

```powershell
Disable-SpanningUsersFromCSVAdvanced  -Path "C:\Test\Users.csv" -UpnColumn 1
```

The result should be:

```plaintext
userPrincipalNames                                                                                licensed
-------------------------                                                                         --------
{willa@doghousetoys.com, kobe@doghousetoys.com, jazzy@doghousetoys.com, cheyenne@doghousetoys.com}  False
```

You can also use a filter on your CSV file if you only wish to remove licenses from a subset of users in the file. The process is the same as the **Enable-SpanningUsersFromCSVAdvanced** function.

```powershell
Disable-SpanningUsersFromCSVAdvanced  -Path "C:\Test\Users.csv" -UpnColumn 1 `
    -FilterColumn 3 -FilterColumnValue "US"
```

The result should be:

```plaintext
userPrincipalName                                   licensed
-------------------------                           --------
{willa@doghousetoys.com, cheyenne@doghousetoys.com}  False
```

## <a name="advanced"></a>Advanced Use Cases

The PowerShell module for Spanning Backup for Office 365 supports the pipeline for many common tasks. This sections details a few key scenarios that you can apply to your organizations managements of Spanning Backup for Office 365 licensing.

### Enable all Unassigned Users

### License an Azure AD Group

Get an Azure Group and Enable a Spanning User for each group member

```powershell
$cred = Get-Credential -Message "Azure AD Admin" -UserName "ruby@doghousetoys.com"

#Uses AzureAd Module
Connect-AzureAd -Credential $cred
#Create an ArrayList
$userList = [System.Collections.ArrayList]@()

Get-AzureADGroup -SearchString "Sales Team" | Get-AzureADGroupMember -All $true | `
    foreach {$userList.Add($_.UserPrincipalName)}
#Submit the list to Spanning
Enable-SpanningUserList -UserPrincipalNames $userList
    
```

### License Users with an Office 365 License

View the complete example for [License Users with an Office 365 License](sample-license-users.md)

### Export Unlicensed Users to CSV

```powershell
Get-SpanningUnassignedUsers | `
Select userPrincipalName, msId, assigned, isAdmin, isDeleted | `
Export-Csv -Path .\sample.csv -NoTypeInformation
```

### Confirm Your Script with -WhatIf

In the event you wish to enable or disable users in bulk you can use the **-WhatIf** switch to test the results of your command without actually applying the command to your tenant. For example if you are using the CSV file above and want to test you script you could use the functions like this:

```powershell
$users2activate = Get-Content -Path "C:\Test\Users.csv"

Enable-SpanningUserList -UserPrincipalNames $users2activate -WhatIf

```

PowerShell will not actually enable the license. It will return What if: statements.

```plaintext
What if: Performing the operation "Enable-SpanningUser" on target "willa@doghousetoys.com".
What if: Performing the operation "Enable-SpanningUser" on target "kobe@doghousetoys.com
What if: Performing the operation "Enable-SpanningUser" on target "jazzy@doghousetoys.com".
What if: Performing the operation "Enable-SpanningUser" on target "cheyenne@doghousetoys.com".
```

### Get User Backup Status

You can get the status of a user's backup by including the `-Status` parameter.

```powershell
$user = Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com -Status $true
$user.backupSummary
```

```plaintext
date       type     userId backup
----       ----     ------ ------
09/21/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
09/21/2021 CALENDAR  12345 @{total=1; partial=0; failed=0; successful=1; data=}
09/21/2021 CONTACT   12345 @{total=1; partial=0; failed=0; successful=1; data=}
09/21/2021 DRIVE     12345 @{total=1; partial=0; failed=0; successful=1; data=}
```

### Get User Historical Backup Status

You can get the historical backup status for a user or users by including the `-Status` and `-StartDate` (and optional `-EndDate`) parameters.

```powershell
$user = Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com -Status $true -StartDate (Get-Date).AddDays(-5)
$user.backupSummary
```

```plaintext
date       type     userId backup
----       ----     ------ ------
10/25/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/25/2021 DRIVE     12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/25/2021 CONTACT   12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/25/2021 CALENDAR  12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/24/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/24/2021 DRIVE     12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/24/2021 CONTACT   12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/24/2021 CALENDAR  12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/23/2021 CONTACT   12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/23/2021 CALENDAR  12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/23/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/23/2021 DRIVE     12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/22/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/22/2021 DRIVE     12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/22/2021 CONTACT   12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/22/2021 CALENDAR  12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/21/2021 CALENDAR  12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/21/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/21/2021 DRIVE     12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/21/2021 CONTACT   12345 @{total=1; partial=0; failed=0; successful=1; data=}
10/20/2021 MAIL      12345 @{total=1; partial=0; failed=0; successful=1; data=}
```

### Get Tenant Backup Status

You can get the overall status of the tenant using the `Get-SpanningTenantBackupSummary` cmdlet.

```powershell
Get-SpanningTenantBackupSummary
```

```plaintext
date       type     backup
----       ----     ------
09/21/2021 CALENDAR @{total=8; partial=0; failed=3; successful=5; data=}
09/21/2021 CONTACT  @{total=8; partial=0; failed=3; successful=5; data=}
09/21/2021 DRIVE    @{total=2; partial=0; failed=0; successful=2; data=}
09/21/2021 SPSITE   @{total=4; partial=0; failed=0; successful=4; data=}
```

## Thank You!

Thank you for reading this far. If you have problems or successes please let me know. I'd love to hear how you are using the module!
