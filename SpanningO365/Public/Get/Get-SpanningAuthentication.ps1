﻿function Get-SpanningAuthentication {

    [CmdletBinding()]
    param(
        [Parameter(
            Position=0,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [String]
        #The API Token from the Spanning Backup Portal Settings Page
        $ApiToken,
        [Parameter(
            Position=1,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [ValidateSet('US','EU','AP')]
        [String]
        #The Region for your Spanning Backups
        $Region,
        [Parameter(
            Position=2,
            Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)
        ]
        [String]
        #The Admin Email address used to generate the API Token
        $AdminEmail
    )

    Write-Verbose "Get-SpanningAuthentication..."
    Write-Verbose "Session ApiToken: $($Script:ApiToken)"
    # Check the ApiToken
    if ([string]::IsNullOrEmpty($Script:ApiToken) -and [string]::IsNullOrEmpty($ApiToken)) {
        $ApiToken = Read-Host 'Enter Api Token'
        # Alternatively
        # throw [System.ArgumentException]'You must supply an API Token value'
    }
    if ([string]::IsNullOrEmpty($ApiToken)) {
        $Script:ApiToken = $ApiToken
    }
    #Check the Region
    if (!$Script:Region -and !$Region) {
        $Region = Read-Host 'Enter Spanning Region (US, EU or AP)'
        # Alternatively
        # throw [System.ArgumentException]'You must supply a Region value'
    }
    if ($Region) {
        $Script:Region = $Region
    }

    #Check AdminEmail
    if (!$Script:AdminEmail -and !$AdminEmail) {
        $AdminEmail = Read-Host 'Enter Admin Email Address'
        # Alternatively
        # throw [System.ArgumentException]'You must supply a Admin Email value'
    }
    if ($AdminEmail) {
        $Script:AdminEmail = $AdminEmail
    }

    $pair = "$($AdminEmail):$($ApiToken)"
    $Script:Pair = $pair

    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $basicAuthValue = "Basic $base64"
    $headers = @{ Authorization = $basicAuthValue }

    #Create the AuthInfo Object
    $AuthInfo = New-Object -TypeName PSCustomObject
    $AuthInfo  | Add-Member -MemberType NoteProperty -Name Headers -Value ($headers) -PassThru | Add-Member -MemberType NoteProperty -Name Region -Value ($Region)
    $Script:AuthInfo = $AuthInfo

    Write-Output $AuthInfo

}

