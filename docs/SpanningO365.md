---
Module Name: SpanningO365
Module Guid: 2029a86b-b4ef-4306-83f0-aac212dbee83
Download Help Link: 
Help Version: 
Locale: en-US
---

# SpanningO365 Module
## Description
The **SpanningO365** module enables administrators to use the Spanning Backup for Office 365 API in PowerShell scripts and automation projects. Once Authenticated an Administrator can use the functions in the module to evaluate licensed and unlicensed users, enable and disable licenses, and determine the status of the Spanning tenant.

## SpanningO365 Cmdlets
### [Clear-SpanningAuthentication](Clear-SpanningAuthentication.md)
Clears the session Authentication variables

### [Disable-SpanningUser](Disable-SpanningUser.md)
[DEPRECATED] - Use Disable-SpanningUserList
Removes the user license from a licensed user

### [Disable-SpanningUserList](Disable-SpanningUserList.md)
Remove licenses from a list of user accounts

### [Disable-SpanningUsersFromCSVAdvanced](Disable-SpanningUsersFromCSVAdvanced.md)
Disable licenses for Spanning users from a comma separated value file.

### [Enable-SpanningUser](Enable-SpanningUser.md)
[DEPRECATED] - Use Enable-SpanningUserList
Apply a license to a user account

### [Enable-SpanningUserList](Enable-SpanningUserList.md)
Apply a license to a list of user accounts

### [Enable-SpanningUsersFromCSVAdvanced](Enable-SpanningUsersFromCSVAdvanced.md)
Enable licenses for Spanning users from a comma separated value file.

### [Get-SpanningAdmins](Get-SpanningAdmins.md)
Returns the admin users from the Spanning Backup Portal

### [Get-SpanningAssignedUsers](Get-SpanningAssignedUsers.md)
Returns the assigned users from the Spanning Backup Portal

### [Get-SpanningAuthentication](Get-SpanningAuthentication.md)
Get-SpanningAuthentication creates the Spanning Auth Header needed for making all Spanning API calls.

### [Get-SpanningNonAdmins](Get-SpanningNonAdmins.md)
Returns the non-admin users from the Spanning Backup Portal

### [Get-SpanningTenantBackupSummary](Get-SpanningTenantBackupSummary.md)
Returns the tenant backup summary information

### [Get-SpanningTenantInfo](Get-SpanningTenantInfo.md)
Returns the tenant information from the Spanning Backup Portal

### [Get-SpanningTenantInfoPaymentStatus](Get-SpanningTenantInfoPaymentStatus.md)
Get the current payment status from the Spanning Portal

### [Get-SpanningUnassignedUsers](Get-SpanningUnassignedUsers.md)
Returns the unassigned users from the Spanning Backup Portal

### [Get-SpanningUser](Get-SpanningUser.md)
Returns the user information information from the Spanning Backup Portal

### [Get-SpanningUsers](Get-SpanningUsers.md)
Returns the user license information for all users from the Spanning Backup Portal

