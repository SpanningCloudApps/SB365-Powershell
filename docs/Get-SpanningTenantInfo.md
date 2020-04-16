---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Get-SpanningTenantInfo

## SYNOPSIS
Returns the tenant information from the Spanning Backup Portal

## SYNTAX

```
Get-SpanningTenantInfo [[-AuthInfo] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Returns the tenant information from the Spanning Backup Portal for the supplied ApiToken, Region, and AdminEmail address

## EXAMPLES

### EXAMPLE 1
```
Get-SpanningTenantInfo
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.

### EXAMPLE 2
```
$myApiToken = "your api token"
$myAdminEmail = "admin@mytenant.onmicrosoft.com"
$myRegion = "US"

Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail | Get-SpanningTenantInfo
```

Supply the three parameters from variables to Get-SpanningAuthentication and pipe the result to Get-SpanningTennantInfo.

## PARAMETERS

### -AuthInfo
The AuthInfo result from Get-SpanningAuthentication.
If not provided the Script varable will be checked.
If null you will be prompted.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
The Spanning API Token is generated in the Spanning Admin Portal.
Go to Settings | API Token to generate and revoke the token.

## RELATED LINKS

[Get-SpanningAuthentication](Get-SpanningAuthentication.md)

[Get-SpanningTenantInfoPaymentStatus](Get-SpanningTenantInfoPaymentStatus.md)

[GitHub Repository: https://github.com/spanningcloudapps](https://github.com/spanningcloudapps)

