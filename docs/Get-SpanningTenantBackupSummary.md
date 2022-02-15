---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Get-SpanningTenantBackupSummary

## SYNOPSIS
Returns the tenant backup summary information

## SYNTAX

```
Get-SpanningTenantBackupSummary [[-AuthInfo] <Object>] [[-StartDate] <DateTime>] [[-EndDate] <DateTime>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the tenant backup summary information from the Spanning Backup Portal.
Backup Summary is available for the past 7 days.

## EXAMPLES

### EXAMPLE 1
```
Get-SpanningTenantBackupSummary
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
The default is for today.

### EXAMPLE 2
```
$myApiToken = "your api token"
```

$myAdminEmail = "admin@mytenant.onmicrosoft.com"
$myRegion = "US"

Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail | Get-SpanningTenantBackupSummary

Supply the three parameters from variables to Get-SpanningAuthentication and pipe the result to Get-SpanningTenantBackupSummary

### EXAMPLE 3
```
Get-SpanningTenantBackupSummary -StartDate (Get-Date).AddDays(-5)
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
The default is for today.

### EXAMPLE 4
```
Get-SpanningTenantBackupSummary -StartDate "11/21/2020" -EndDate "11/23/2020"
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.
The default is for today.

## PARAMETERS

### -AuthInfo
This parameter takes an AuthInfo object from Get-SpanningAuthentication.

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

### -StartDate
This parameter takes a Date for the beginning date range.
A maximum of 7 days is available.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -EndDate
This parameter takes a Date for the ending date range.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

[Get-SpanningAuthentication]()

[Get-SpanningTenantInfo]()

[GitHub Repository: https://github.com/spanningcloudapps]()
