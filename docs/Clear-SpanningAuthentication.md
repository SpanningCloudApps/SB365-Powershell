---
external help file: SpanningO365-help.xml
Module Name: SpanningO365
online version:
schema: 2.0.0
---

# Clear-SpanningAuthentication

## SYNOPSIS
Clears the session Authentication variables

## SYNTAX

```
Clear-SpanningAuthentication [<CommonParameters>]
```

## DESCRIPTION
Clears all script level session variables associated with authentication.
This cmdlet is useful when switching bewteen environments requireing different API Tokens.

## EXAMPLES

### EXAMPLE 1
```
Clear-SpanningAuthentication
```

Clear the session ApiToken, Region, and AdminEmail variables.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
The variables are populated by the Get-SpanningAuthentication cmdlet.

## RELATED LINKS

[Get-SpanningAuthentication](Get-SpanningAuthentication.md)

[GitHub Repository: https://github.com/spanningcloudapps](https://github.com/spanningcloudapps)

