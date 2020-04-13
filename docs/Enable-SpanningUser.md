---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Enable-SpanningUser

## SYNOPSIS
Apply a license to a user account

## SYNTAX

```
Enable-SpanningUser [[-AuthInfo] <Object>] [-UserPrincipalName] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Apply a license to the UserPrincipalName.
If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

## EXAMPLES

### EXAMPLE 1
```
Enable-SpanningUser -UserPrincipalName user@domain.com
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

### -UserPrincipalName
User Principal Name (email address) of the user to enable.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
The Spanning API Token is generated in the Spanning Admin Portal.
Go to Settings | API Token to generate and revoke the token.

## RELATED LINKS

[Get-SpanningAuthentication](Get-SpanningAuthentication.md)

[Get-SpanningUser](Get-SpanningUser.md)

[Disable-SpanningUser](Disable-SpanningUser.md)

[GitHub Repository: https://github.com/spanningcloudapps](https://github.com/spanningcloudapps)

