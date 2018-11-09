# Spanning Backup for Office 365 REST API PowerShell Module

> NOTE: This is an open source project licensed under Apache 2.0 and is not officially supported by Spanning Cloud Apps.  If you have questions, problems or suggestions, please log an issue in this project

## Download the Module

- Download or clone the repository
- Extract the files to a local folder

## Authentication

Use the `Get-SpanningAuthentication` cmdlet to pass your authentication parameters to the Spanning Backup for Office 365 REST API, you will need to generate API token and identify your region.

- Acquire your API Token
  - Log in to the Spanning Backup Administrative UI 
  - Navigate to the **Settings** page
  - Click **Generate Token**
  - Copy and save the token string.
- Identify your region
  - Your region will be `US, EU or AP`.  
  - If you are unsure which regional deployment your Spanning Backup is in, you can locate it within the URL of the administrative interface.  e.g. [https://o365-**us**.spanningbackup.com/](https://o365-us.spanningbackup.com/)

## Install the PowerShell Module

- From the command prompt, launch PowerShell
- Type `Import-Module` followed by the path to the `SpanningO365` module
    ```powershell
    Import-Module .\SpanningO365
    ```
- Verify the import by typing `Get-Module` and check for `SpanningO365`
- You can view the available commands with `Get-Command`
    ```powershell
    Get-Command -Module SpanningO365
    ```
- Once the module is imported, you can begin executing the functions as described below

## Functions

### Get-SpanningAuthentication

Creates the Spanning Auth Header needed for making all Spanning API calls.

```powershell
PS> Get-SpanningAuthentication -ApiToken "your api token" -Region "US" -AdminEmail "admin@mydomain.com"
```

### Get-SpanningTenantInfo

Returns the number of licenses available, assigned, and whether the account is paid, trial, or expired

```powershell
PS> Get-SpanningAuthentication -ApiToken "your api token" -Region "US" -AdminEmail "admin@mydomain.com"  
PS> Get-SpanningTenantInfo

licenses users assigned status
-------- ----- -------- ------
     124    15       15   paid
```

### Get-SpanningTenantInfoPaymentStatus

Returns only whether the account is on trial or is currently paid

```powershell
PS> Get-SpanningTenantPaymentStatus

paid
```

### Enable-SpanningUser

Takes UPN as a single argument. If left blank, you will be prompted for this. Enables Spanning for the designated UPN and returns userPrincipalName and license status

```powershell
PS> Enable-SpanningUser a@contoso.com

userPrincipalName  licensed
-----------------  --------
a@contoso.com          True
```

### Disable-SpanningUser

Takes UPN as a single argument. If left blank, you will be prompted for this. Disables Spanning for the designated UPN and returns userPrincipalName and license status

```powershell
PS> Disable-SpanningUser a@contoso.com

userPrincipalName  licensed
-----------------  --------
a@contoso.com         False
```

### Get-SpanningUser

Takes UPN as a single argument and returns user status

```powershell
PS> Get-SpanningUser -UserPrincipalName "a@contoso.com"

email              assigned  isAdmin  isDeleted
-----------------  --------  -------  ---------
a@contoso.com          True     True      False
```

Alternatively takes a UserType of `All, Assigned, Unassigned, Admin, NonAdmin`

```powershell
PS> Get-SpanningUser -UserType Admin

email              assigned  isAdmin  isDeleted
-----------------  --------  -------  ---------
a@contoso.com          True     True      False
```

### Get-SpanningUsers

Returns an unsorted list of all users within the tenant and their status

```powershell
PS> Get-SpanningUsers

userPrincipalName : a@contoso.com
msId              : a814f0a7-7023-4ac6-a771-5dbdd5259b0c
assigned          : True
isAdmin           : True
isDeleted         : False

userPrincipalName : b@contoso.com
msId              : a814f0a7-7023-4ac6-a771-5dbdd5259b0c
assigned          : True
isAdmin           : False
isDeleted         : False
```

### Get-SpanningAdmins

Returns a list of all UPN's currently designated as Spanning administrators

```powershell
PS> Get-SpanningAdmins

userPrincipalName : a@contoso.com
msId              : a814f0a7-7023-4ac6-a771-5dbdd5259b0c
assigned          : True
isAdmin           : True
isDeleted         : False
```

### Get-SpanningNonAdmins

Returns a list of all UPN's that are not currently designated as Spanning administrators

```powershell
PS> Get-SpanningNonAdmins

userPrincipalName : b@contoso.com
msId              : a814f0a7-7023-4ac6-a771-5dbdd5259b0c
assigned          : True
isAdmin           : False
isDeleted         : False

userPrincipalName : c@contoso.com
msId              : a914f0a7-7023-4ac6-a771-5dbdd5259a1d
assigned          : True
isAdmin           : False
isDeleted         : False
```

### Get-SpanningAssignedUsers

Returns a list of all UPN's for which Spanning is enabled

```powershell
PS> Get-SpanningAssignedUsers

userPrincipalName : a@contoso.com
msId              : a814f0a7-7023-4ac6-a771-5dbdd5259b0c
assigned          : True
isAdmin           : True
isDeleted         : False

userPrincipalName : b@contoso.com
msId              : a814f0a7-7023-4ac6-a771-5dbdd5259b0c
assigned          : True
isAdmin           : False
isDeleted         : False

userPrincipalName : c@contoso.com
msId              : a914f0a7-7023-4ac6-a771-5dbdd5259a1d
assigned          : True
isAdmin           : False
isDeleted         : False
```

### Get-SpanningUnassignedUsers

Returns a list of all UPN's for which Spanning is not enabled

```powershell
PS> Get-SpanningUnassignedUsers

userPrincipalName : d@contoso.com
msId              : a524f0a7-7023-4ac6-a771-5dbdd5259c0d
assigned          : False
isAdmin           : True
isDeleted         : False
```

### Clear-SpanningAuthentication

Removes the Spanning global credentials from the session

```powershell
PS> Clear-SpanningAuthentication
```

### Enable-SpanningUsersfromCSVAdvanced

Imports users from a CSV file. Takes 4 arguments.

- The first argument is the fully qualified path to a CSV file; the CSV must contain only a single header column.
- The second argument is the number (starting at 0) of the column containing UserPrincipalName in the CSV.
- The third argument is the number of the column which contains the attribute you wish to use to determine Spanning enablement.
- The fourth argument is the attribute string you wish to use.

Take, for example, the follow1ing CSV at path c:\ps\csv_import.csv:

|Name|UPN|Department|Geography|
|:----|:----|:----|:----|
|Andy|a@contoso.com|Finance|US|
|Bob|b@contoso.com|Sales|EU|
|Charlie|c@contosocom|Finance|EU|
|Doug|d@contoso.com|Engineering|US|

To enable all individuals in the Finance department, the command would be:

```powershell
Enable-SpanningUsersfromCSVAdvanced "c:\ps\csv_import.csv" 1 2 Finance
```

### Disable-SpanningUsersfromCSVAdvanced

Imports users from a CSV file. Takes 4 arguments.

- The first argument is the fully qualified path to a CSV file; the CSV must contain only a single header column.
- The second argument is the number (starting at 0) of the column containing UserPrincipalName in the CSV.
- The third argument is the number of the column which contains the attribute you wish to use to determine Spanning disablement.
- The fourth argument is the attribute string you wish to use.

Take, for example, the follow1ing CSV at path c:\ps\csv_import.csv:

|Name|UPN|Department|Geography|
|:----|:----|:----|:----|
|Andy|a@contoso.com|Finance|US|
|Bob|b@contoso.com|Sales|EU|
|Charlie|c@contosocom|Finance|EU|
|Doug|d@contoso.com|Engineering|US|

To disable all individuals in the Finance department, the command would be:

```powershell
Disable-SpanningUsersfromCSVAdvanced "c:\ps\csv_import.csv" 1 2 Finance
```
