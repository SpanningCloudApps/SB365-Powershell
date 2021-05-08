Param (
    [String]$Module
)
BeforeAll{
    $functionName = (Get-Item $PSCommandPath ).BaseName.Replace(".Tests","")
    $ModuleData = Get-Module $Module
    $Function = $ModuleData.Invoke({Param($Module) Get-Command -Module $Module}, $Module) | Where-Object { $_.Name -eq $functionName}
    $Function | Out-Null # ToDo - Hide ScriptAnalyzer Scope Error
}
Describe 'Get-SpanningTenantBackupSummary Tests' -Tag "Structure" {

   Context 'Parameters for Get-SpanningTenantBackupSummary'{

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
            [String]$Function.Parameters.StartDate.Attributes.Position | Should -Be '1'
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
            [String]$Function.Parameters.EndDate.Attributes.Position | Should -Be '2'
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
