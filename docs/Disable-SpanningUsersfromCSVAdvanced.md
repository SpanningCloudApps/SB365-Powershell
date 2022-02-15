---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Disable-SpanningUsersFromCSVAdvanced

## SYNOPSIS
Disable licenses for Spanning users from a comma separated value file.

## SYNTAX

### None (Default)
```
Disable-SpanningUsersFromCSVAdvanced [[-AuthInfo] <Object>] -Path <String> -UpnColumn <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Filter
```
Disable-SpanningUsersFromCSVAdvanced [[-AuthInfo] <Object>] -Path <String> -UpnColumn <Int32>
 [-FilterColumn <Int32>] -FilterColumnValue <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disable licenses for Spanning users from a comma separated value file.
If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

## EXAMPLES

### EXAMPLE 1
```
Disable-SpanningUsersfromCSVAdvanced -Path .\users.csv -UpnColumn 1 -FilterColumn 2 -FilterColumnValue "Finance"
```

Disable the users with a value of Finance in the third column.
Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.

### EXAMPLE 2
```
Disable-SpanningUsersfromCSVAdvanced -Path .\users.csv -UpnColumn 1 -FilterColumn 2 -FilterColumnValue "Finance" -WhatIf
```

Test what would happen if you disabled the users with a value of Finance in the third column.

### EXAMPLE 3
```
Disable-SpanningUsersfromCSVAdvanced -Path .\users.csv -UpnColumn 0 -WhatIf
```

Process all entries in the CSV file and show the accounts that could be disable.

## PARAMETERS

### -AuthInfo
The AuthInfo result from Get-SpanningAuthentication.
If not provided the Script variable will be checked.
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

### -Path
Path to the CSV file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpnColumn
Column index containing the Use Principal Name

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterColumn
Column index of the column to filter on

```yaml
Type: Int32
Parameter Sets: Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterColumnValue
Filter string to apply to filter column for comparison

```yaml
Type: String
Parameter Sets: Filter
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[Enable-SpanningUsersfromCSVAdvanced](Enable-SpanningUsersfromCSVAdvanced.md)

[GitHub Repository: https://github.com/spanningcloudapps](https://github.com/spanningcloudapps)

