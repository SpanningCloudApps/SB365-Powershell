# Usage Examples

## Generate Spanning API key

In order to authenticate with the Spanning Backup for Office 365 API you need an API token.

1. Login to the Spanning Backup portal and click **Settings**.
1. In the **API Token** section click **Generate Token**. Note: if the button says **Revoke Token** a token has already been generated. You either need to revoke and regenerate the token or find out who has the token.
1. Record the API Token in a safe place. Once you navigate away from the page it will not be shown again.

Now that you have the API Token you only need to know your region and the email address of the administrator for executing the commands. (Your region was selected when you installed the app for the first time. You can determin your region from the URL of the portal:

- https<span></span>://o365-**us**.spanningbackup.com/ is the **US** Region for the United States
- https<span></span>://o365-**eu**.spanningbackup.com/ is the **EU** Region for Europe
- https<span></span>://o365-**ap**.spanningbackup.com/ is the **AP** Region for Australia/Pacific

```plaintext
For these examples we will use the following information:
- API Token: 2a4d91f3-dc91-46c5-bfa9-a6f0adefed33
- Region: US
- Admin Email: MeganB@doghousetoys.com
```

## Authenticate with Get-SpanningAuthentication

The **Get-SpanningAuthentication** function creates the necessary authentication headers for calling the Spanning Backup API. If you call any other function without supplying the authentication information you will be prompted for the necessary information, so you might as well start here! While you could execute **Get-SpanningAuthentication** without any parameters and then fill in the prompts, the easiest way to start is to simply call the **Get-SpanningAuthentication** function with the necessary parameters for your tenant.

**Note:** These PowerShell samples are wrapped for clarity and use the backtick character "`" in the event you want to copy and paste them.

```powershell
Get-SpanningAuthentication -ApiToken "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33" `
    -Region "US" -AdminEmail "MeganB@doghousetoys.com"
```

This does two things, it returns an **AuthInfo** object and stores the **AuthInfo** in a session varaible. The benefit of the object is that you can use the PowerShell pipeline to send the AuthInfo to another Spanning function. For example to get a list of Administrators in one line you could execute:

```powershell
Get-SpanningAuthentication -ApiToken "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33" `
    -Region "US" -AdminEmail "MeganB@doghousetoys.com" | Get-SpanningAdmins
```

Alternatively, you could store the **AuthInfo** in a variable and reuse it:

```powershell
$myAuthinfo = Get-SpanningAuthentication -ApiToken "2a4d91f3-dc91-46c5-bfa9-a6f0adefed33" `
    -Region "US" -AdminEmail "MeganB@doghousetoys.com"

Get-SpanningAdmins -AuthInfo $myAuthinfo
```

It's really up to you, you have the flexibility to use the Authentication the way that suits you best. If you need to switch contexts you can clear out the stored **AuthInfo** with the **Clear-SpanningAuthentication** function.

```powershell
Clear-SpanningAuthentication
```

## Listing Users

You can list the different users from the Spanning Portal with the **Get-User** function. This function can take either a specific UPN for a user or a user type enumeration of:

- All: All users in the Spanning portal
- Admins: Users assigned to the Admin Role
- NonAdmins: Users who are not administrators
- Assigned: Users assigned a Spanning Backup for Office 365 license
- Unassigned: Users who are not assigned a Spanning Backup for Office 365 license

To retrieve the status of a simgle user "MeganB@doghousetoys.com":

```powershell
Get-SpanningUser -UserPrincipalName "MeganB@doghousetoys.com"
```

To determine the currently assigned Administrators:

```powershell
Get-SpanningUser -UserType Admins
```

For backwards compatability to the previous version of the module you can still explicitly call the following functions and retrieve the associated users:

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



Get-SpanningTenantInfo
Get-SpanningTenantPaymentInfo

## Enabling Users

Enable-SpanningUser
Enable-SpanningUserFromCSVAdvanced

## Disabling Users

Disable-SpanningUser
Disable-SpanningUserFromCSVAdvanced

```powershell

```

## License an Azure AD Group

Get an Azure Group and Enable a Spanning User for each group member

```powershell
#Uses AzureAd Module
Connect-AzureAd

Get-AzureADGroup -SearchString "Sales Team" | Get-AzureADGroupMember | foreach {Enable-SpanningUser $_.UserPrincipalName }
```

## License Users with an Office 365 License

## Disable Spanning Users

Show -WhatIf switch

