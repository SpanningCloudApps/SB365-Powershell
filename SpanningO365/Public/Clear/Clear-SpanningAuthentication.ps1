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
    #ToDo : Add Write-Verbose
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'Region'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'ApiToken'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'AdminEmail'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'Pair'
    Remove-Variable -Scope Script -ErrorAction Ignore -Name 'AuthInfo'

}

