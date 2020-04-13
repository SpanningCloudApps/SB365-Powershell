---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Get-SpanningUser

## SYNOPSIS
Returns the user information information from the Spanning Backup Portal

## SYNTAX

### Get Single User
```
Get-SpanningUser [[-AuthInfo] <Object>] [-UserPrincipalName] <String> [<CommonParameters>]
```

### Get Multiple Users
```
Get-SpanningUser [[-AuthInfo] <Object>] [[-UserType] <String>] [[-Size] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns the user license information from the Spanning Backup Portal for the supplied user principal name.
If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

## EXAMPLES

### EXAMPLE 1
```
Get-SpanningUser -UserPrincipalName ruby@doghousetoys.com
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.

### EXAMPLE 2
```
Get-SpanningUser -UserType Admins
```

Return only Admin Users
Without any parameters you will be prompted for ApiToken, Region, and AdminEmail if Get-SpanningAuthentication has not been previously called.

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

### -UserPrincipalName
This parameter is the UPN of the user to disable.

```yaml
Type: String
Parameter Sets: Get Single User
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UserType
This parameter filters to specific user types from the set All, Admins, NonAdmins, Assigned, Unassigned.

```yaml
Type: String
Parameter Sets: Get Multiple Users
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Size
This parameter takes a page size parameter for the request. It defaults to 1000.

```yaml
Type: Int32
Parameter Sets: Get Multiple Users
Aliases:

Required: False
Position: 4
Default value: 1000
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

[Get-SpanningAuthentication](Get-SpanningAuthentication.md)

[GitHub Repository: https://github.com/spanningcloudapps](https://github.com/spanningcloudapps)

