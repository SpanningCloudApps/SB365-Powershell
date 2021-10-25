Param (
    [String]$Module
)
BeforeAll{
    $functionName = (Get-Item $PSCommandPath ).BaseName.Replace(".Tests","")
    $ModuleData = Get-Module $Module
    $Function = $ModuleData.Invoke({Param($Module) Get-Command -Module $Module}, $Module) | Where-Object { $_.Name -eq $functionName}
    $Function | Out-Null # ToDo - Hide ScriptAnalyzer Scope Error
}
Describe 'Get-SpanningUser Tests' -Tag "Structure" {

   Context 'Parameters for Get-SpanningUser' {

        It 'Has a Parameter called AuthInfo' {
            $Function.Parameters.Keys.Contains('AuthInfo') | Should -Be 'True'
            }
        It 'AuthInfo Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.AuthInfo.Attributes.Mandatory | Should -Be 'False'
            }
        It 'AuthInfo Parameter is of Object Type' {
            $Function.Parameters.AuthInfo.ParameterType.FullName | Should -Be 'System.Object'
            }
        It 'AuthInfo Parameter is member of ParameterSets' {
            [String]$Function.Parameters.AuthInfo.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'AuthInfo Parameter Position is defined correctly' {
            [String]$Function.Parameters.AuthInfo.Attributes.Position | Should -Be '0'
            }
        It 'Does AuthInfo Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.AuthInfo.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does AuthInfo Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.AuthInfo.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does AuthInfo Parameter use advanced parameter Validation? ' {
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for AuthInfo '{
            $function.Definition.Contains('.PARAMETER AuthInfo') | Should -Be 'True'
            }
        It 'Has a Parameter called UserPrincipalName' {
            $Function.Parameters.Keys.Contains('UserPrincipalName') | Should -Be 'True'
            }
        It 'UserPrincipalName Parameter is Identified as Mandatory being True' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.Mandatory | Should -Be 'True'
            }
        It 'UserPrincipalName Parameter is of String Type' {
            $Function.Parameters.UserPrincipalName.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'UserPrincipalName Parameter is member of ParameterSets' {
            [String]$Function.Parameters.UserPrincipalName.ParameterSets.Keys | Should -Be 'Get Single User'
            }
        It 'UserPrincipalName Parameter Position is defined correctly' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.Position | Should -Be '1'
            }
        It 'Does UserPrincipalName Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does UserPrincipalName Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does UserPrincipalName Parameter use advanced parameter Validation? ' {
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'True'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for UserPrincipalName '{
            $function.Definition.Contains('.PARAMETER UserPrincipalName') | Should -Be 'True'
            }
        It 'Has a Parameter called UserType' {
            $Function.Parameters.Keys.Contains('UserType') | Should -Be 'True'
            }
        It 'UserType Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.UserType.Attributes.Mandatory | Should -Be 'False'
            }
        It 'UserType Parameter is of String Type' {
            $Function.Parameters.UserType.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'UserType Parameter is member of ParameterSets' {
            [String]$Function.Parameters.UserType.ParameterSets.Keys | Should -Be 'Get Multiple Users'
            }
        It 'UserType Parameter Position is defined correctly' {
            [String]$Function.Parameters.UserType.Attributes.Position | Should -Be '2'
            }
        It 'Does UserType Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.UserType.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does UserType Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.UserType.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does UserType Parameter use advanced parameter Validation? ' {
            $Function.Parameters.UserType.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.UserType.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.UserType.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.UserType.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.UserType.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for UserType '{
            $function.Definition.Contains('.PARAMETER UserType') | Should -Be 'True'
            }
        It 'Has a Parameter called Status' {
            $Function.Parameters.Keys.Contains('Status') | Should -Be 'True'
            }
        It 'Status Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.Status.Attributes.Mandatory | Should -Be 'False'
            }
        It 'Status Parameter is of Boolean Type' {
            $Function.Parameters.Status.ParameterType.FullName | Should -Be 'System.Boolean'
            }
        It 'Status Parameter is member of AllParameterSets' {
            [String]$Function.Parameters.Status.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'Status Parameter Position is defined correctly' {
            [String]$Function.Parameters.Status.Attributes.Position | Should -Be '4'
            }
        It 'Does Status Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.Status.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does Status Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.Status.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does Status Parameter use advanced parameter Validation? ' {
            $Function.Parameters.Status.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.Status.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.Status.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.Status.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.Status.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for Status '{
            $function.Definition.Contains('.PARAMETER Status') | Should -Be 'True'
            }
        It 'Has a Parameter called Size' {
            $Function.Parameters.Keys.Contains('Size') | Should -Be 'True'
            }
        It 'Size Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.Size.Attributes.Mandatory | Should -Be 'False'
            }
        It 'Size Parameter is of Int32 Type' {
            $Function.Parameters.Size.ParameterType.FullName | Should -Be 'System.Int32'
            }
        It 'Size Parameter is member of ParameterSets' {
            [String]$Function.Parameters.Size.ParameterSets.Keys | Should -Be 'Get Multiple Users'
            }
        It 'Size Parameter Position is defined correctly' {
            [String]$Function.Parameters.Size.Attributes.Position | Should -Be '3'
            }
        It 'Does Size Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.Size.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does Size Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.Size.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does Size Parameter use advanced parameter Validation? ' {
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for Size '{
            $function.Definition.Contains('.PARAMETER Size') | Should -Be 'True'
        }
        It 'Has a Parameter called InAAD' {
            $Function.Parameters.Keys.Contains('InAAD') | Should -Be 'True'
            }
        It 'InAAD Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.InAAD.Attributes.Mandatory | Should -Be 'False'
            }
        It 'InAAD Parameter is of String Type' {
            $Function.Parameters.InAAD.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'InAAD Parameter is member of ParameterSets' {
            [String]$Function.Parameters.InAAD.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'InAAD Parameter Position is defined correctly' {
            [String]$Function.Parameters.InAAD.Attributes.Position | Should -Be '5'
            }
        It 'Does InAAD Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.InAAD.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does InAAD Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.InAAD.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does InAAD Parameter use advanced parameter Validation? ' {
            $Function.Parameters.InAAD.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.InAAD.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.InAAD.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.InAAD.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.InAAD.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for InAAD '{
            $function.Definition.Contains('.PARAMETER InAAD') | Should -Be 'True'
            }
        It 'Has a Parameter called StartDate' {
            $Function.Parameters.Keys.Contains('StartDate') | Should -Be 'True'
            }
        It 'StartDate Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.StartDate.Attributes.Mandatory | Should -Be 'False'
            }
        It 'StartDate Parameter is of DateTime Type' {
            $Function.Parameters.StartDate.ParameterType.FullName | Should -Be 'System.DateTime'
            }
        It 'StartDate Parameter is member of ParameterSets' {
            [String]$Function.Parameters.StartDate.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'StartDate Parameter Position is defined correctly' {
            [String]$Function.Parameters.StartDate.Attributes.Position | Should -Be '6'
            }
        It 'Does StartDate Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.StartDate.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does StartDate Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.StartDate.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does StartDate Parameter use advanced parameter Validation? ' {
            $Function.Parameters.StartDate.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.StartDate.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.StartDate.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.StartDate.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.StartDate.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for StartDate '{
            $function.Definition.Contains('.PARAMETER StartDate') | Should -Be 'True'
            }
        It 'Has a Parameter called EndDate' {
            $Function.Parameters.Keys.Contains('EndDate') | Should -Be 'True'
            }
        It 'EndDate Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.EndDate.Attributes.Mandatory | Should -Be 'False'
            }
        It 'EndDate Parameter is of DateTime Type' {
            $Function.Parameters.EndDate.ParameterType.FullName | Should -Be 'System.DateTime'
            }
        It 'EndDate Parameter is member of ParameterSets' {
            [String]$Function.Parameters.EndDate.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'EndDate Parameter Position is defined correctly' {
            [String]$Function.Parameters.EndDate.Attributes.Position | Should -Be '7'
            }
        It 'Does EndDate Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.EndDate.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does EndDate Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.EndDate.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does EndDate Parameter use advanced parameter Validation? ' {
            $Function.Parameters.EndDate.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.EndDate.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.EndDate.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.EndDate.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.EndDate.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for EndDate '{
            $function.Definition.Contains('.PARAMETER EndDate') | Should -Be 'True'
            }
    }
    Context "Function $($function.Name) - Help Section" {

        It "Function $($function.Name) Has show-help comment block" {
            $function.Definition.Contains('<#') | Should -Be 'True'
            $function.Definition.Contains('#>') | Should -Be 'True'
        }
        It "Function $($function.Name) Has show-help comment block has a.SYNOPSIS" {
            $function.Definition.Contains('.SYNOPSIS') -or $function.Definition.Contains('.Synopsis') | Should -Be 'True'
        }
        It "Function $($function.Name) Has show-help comment block has an example" {
            $function.Definition.Contains('.EXAMPLE') | Should -Be 'True'
        }
        It "Function $($function.Name) Is an advanced function" {
            $function.CmdletBinding | Should -Be 'True'
            $function.Definition.Contains('param') -or  $function.Definition.Contains('Param') | Should -Be 'True'
        }
    }
}