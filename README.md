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
  - If you are unsure which regional deployment your Spanning Backup is in, you can locate it within the URL of the administrative interface.  e.g. https<span></span>://o365-**us**.spanningbackup.com/

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

## Documentation

You can view the detailed documentation in the [Documentation](./docs/about_SpanningO365.md). A great place to start by reviewing the [Usage Samples](samples.md). If you have any questions or comments please raise an issue and we'll follow up.

## Introductory Video

<script src="//fast.wistia.com/embed/medias/7j46uee1ko.jsonp" async></script>
<script src="//fast.wistia.com/assets/external/E-v1.js" async></script>
<span class="wistia_embed wistia_async_7j46uee1ko popover=true popoverAnimateThumbnail=true" style="display:inline-block;height:169px;width:300px">&nbsp;</span>
