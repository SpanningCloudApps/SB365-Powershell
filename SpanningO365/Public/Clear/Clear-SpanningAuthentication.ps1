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

