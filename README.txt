### Getting Started ###
- Unzip the file. Put the PSM1 file somewhere on your hard drive. 
- From the command prompt, launch PowerShell.
- Then run "Import-Module" followed by the path to the location
- Verify the import with “Get-Module” and check for “spanning_o365” 
- Once the file is there you'll have access to all the module functions, described below.

### Authentication ###
To find your API key, you'll need to log into the Spanning Administrative UI, where you can find it under "Settings"

Region will be either EU or US. Ask your Spanning root admin for this information.

- You can hard-code your API key, region, and API key to the module (PSM1) file if you wish to do so, at the very top of the module.
- If credentials are present in the module (PSM1) file, you will not be prompted for them during use. 
- If there are no credentials present in the module (PSM1) file, you will be prompted to supply them the first time you call a command, and they will persist for the duration of the session.
- If you enter the wrong credentials or wish to switch tenants, you can use the command Clear-SpanningAuthentication


### Functions ###

 Get-TenantInfo
 - Will return the number of licenses available, assigned, and whether the account is paid, trial, or expired

 Get-TenantInfoPaymentstatus
 - Returns only whether the account is on trial or is currently paid

 Enable-SpanningUser
 - Takes UPN as a single argument. If left blank, you will be prompted for this. Enables Spanning for the designated UPN and returns user email, MSID, and status
 eg: Enable-SpanningUser donald@domain.com

 Disable-SpanningUser
 - Takes UPN as a single argument. If left blank, you will be prompted for this. Disables Spanning for the designated UPN and returns user email, MSID, and status
 eg: Disable-SpanningUser donald@domain.com

 Get-SpanningUsers
 - Returns an unsorted list of all users within the tenancy and their status

 Get-SpanningUser
 - Takes UPN as a single argument and returns user status
 eg: Get-SpanningUser donald@domain.com

 Get-SpanningAdmins
 - Returns a list of all UPN's currently designated as Spanning administrators

 Get-SpanningNonAdmins
 - Returns a list of all UPN's that are not currently designated as Spanning administrators

 Get-SpanningAssignedUsers
 - Returns a list of all UPN's for which Spanning is enabled

 Get-SpanningUnassignedUsers
 - Returns a list of all UPN's for which Spanning is not enabled 

 Clear-SpanningAuthentication
 - Removes the Spanning global credentials from the session

 Enable-SpanningUsersfromCSVAdvanced
 - Imports users from a CSV file. Takes 4 arguments. The first argument is the fully qualified path to a CSV file; the CSV must contain only a single header column. The second argument is the number (starting at 0) of the column containing UserPrincipalName in the CSV. The third argument is the number of the column which contains the attribute you wish to use to determine Spanning enablement. The fourth argument is the attribute string you wish to use.

Take, for example, the following CSV at path c:\ps\csv_import.csv:

Name	UPN		Department	Geography
Andy	a@contoso.com	Finance		US
Bob	b@contoso.com	Sales		EU
Charlie	c@contosocom	Finance		EU
Doug	d@contoso.com	Engineering	US

If I wanted to enable all individuals in the finance department, my command would look like this:
Enable-SpanningUsersfromCSVAdvanced "c:\ps\csv_import.csv" 1 2 Finance

Broken down, we are looking at the CSV at c:\ps\csv_import.csv, and enabling the UPN's in column 1 where column 2 equals 'Finance'

 