function Get-SpanningUnassignedUsers {
    <#
    .SYNOPSIS
        Returns the unassigned users from the Spanning Backup Portal
    .DESCRIPTION
        Returns the unassigned users information from the Spanning Backup Portal.
        If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email
    .PARAMETER AuthInfo
        This parameter takes an AuthInfo object from Get-SpanningAuthentication.
    .PARAMETER Size
        This parameter takes a page size parameter for the request. It defaults to 1000.
    .EXAMPLE
        Get-SpanningUnassignedUsers
        Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
    .NOTES
        The Spanning API Token is generated in the Spanning Admin Portal. Go to Settings | API Token to generate and revoke the token.
    .LINK
        Get-SpanningAuthentication
    .LINK
        Get-SpanningUser -UserType Unassigned
    .LINK
        GitHub Repository: https://github.com/spanningcloudapps
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "", Justification="Backward compatibility")]
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="AuthInfo from Get-SpanningAuthentication")
        ]
        #The AuthInfo result from Get-SpanningAuthentication. If not provided the Script varable will be checked. If null you will be prompted.
        $AuthInfo,
        [Parameter(
            Position=1,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="Page size for request.")]
        [Int]
        #Request Size parameter for User requests, default 1000
        $Size = 1000
    )
    Write-Verbose "Get-SpanningUnassignedUsers"
    if (!$AuthInfo) {
        Write-Verbose "No AuthInfo provided, checking Session State"
        $AuthInfo = Get-AuthInfo
     }

     Write-Output (Get-SpanningUser -AuthInfo $AuthInfo -UserType Unassigned -Size $Size)

}

