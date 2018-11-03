## Samples

Get an Azure Group and Enable a Spanning User for each group member

```powershell
#Uses AzureAd Module
Connect-AzureAd

Get-AzureADGroup -SearchString "Sales Team" | Get-AzureADGroupMember | foreach {Enable-SpanningUser $_.UserPrincipalName }
```
