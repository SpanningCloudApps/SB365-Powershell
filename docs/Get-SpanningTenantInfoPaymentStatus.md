---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Get-SpanningTenantInfoPaymentStatus

## SYNOPSIS
Get the current payment status from the Spanning Portal

## SYNTAX

```
Get-SpanningTenantInfoPaymentStatus [[-AuthInfo] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Get the current payment status from the Spanning Portal.
If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

## EXAMPLES

### EXAMPLE 1
```
Get-SpanningTenantInfoPaymentStatus
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
The Spanning API Token is generated in the Spanning Admin Portal.
Go to Settings | API Token to generate and revoke the token.

## RELATED LINKS

[Get-SpanningAuthentication]()

[Get-SpanningTenantInfo]()

[GitHub Repository: https://github.com/spanningcloudapps]()

