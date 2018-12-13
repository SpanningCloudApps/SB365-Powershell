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
Get-SpanningUser [[-AuthInfo] <Object>] [[-UserType] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the user license information from the Spanning Backup Portal for the supplied user principal name.
If Authentication information is not supplied, or if you have not previously called Get-SpanningAuthentication, you will be prompted for ApiToken, Region, and Admin Email

## EXAMPLES

### EXAMPLE 1
```
Get-SpanningUser -UserPrincipalName
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
User Principal Name (email address) of the user to return.

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
User type to return

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
The Spanning API Token is generated in the Spanning Admin Portal.
Go to Settings | API Token to generate and revoke the token.

## RELATED LINKS

[Get-SpanningAuthentication]()

[GitHub Repository: https://github.com/spanningcloudapps]()

