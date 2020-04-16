---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Get-SpanningAuthentication

## SYNOPSIS
Get-SpanningAuthentication creates the Spanning Auth Header needed for making all Spanning API calls.

## SYNTAX

```
Get-SpanningAuthentication [[-ApiToken] <String>] [[-Region] <String>] [[-AdminEmail] <String>]
 [[-Connection] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
All cmdlets in this module use the AuthInfo returned by this cmdlet.
If you omit the AuthInfo parameter the
script level variables are checked and, if null, a call s made to Get-SpanningAuthentication.

## EXAMPLES

### EXAMPLE 1
```
Get-SpanningAuthentication
```

Without any parameters you will be prompted for ApiToken, Region, and AdminEmail.

### EXAMPLE 2
```
Get-SpanningAuthentication -ApiToken "your api token" -Region "US" -AdminEmail "admin@mydomain.com"
```

Supply the three parameters on the command line.

### EXAMPLE 3
```
$myApiToken = "your api token"
```

$myAdminEmail = "admin@mytenant.onmicrosoft.com"
$myRegion = "US"
Get-SpanningAuthentication -ApiToken $myApiToken -Region $myRegion -AdminEmail $myAdminEmail
Supply the three parameters from variables.

### EXAMPLE 4
```
Get-SpanningAuthentication | Get-SpanningTenantInfo
```

Pipe the results of Get-SpanningAuthentication to Get-SpanningInfo.

## PARAMETERS

### -ApiToken
The API Token from the Spanning Backup Portal Settings Page

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Region
The Region for your Spanning Backups

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -AdminEmail
The Admin Email address used to generate the API Token

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Connection
This parameter takes a Azure Connection for secure automation

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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

[Clear-SpanningAuthentication](Clear-SpanningAuthentication.md)

[GitHub Repository: https://github.com/spanningcloudapps](https://github.com/spanningcloudapps)

