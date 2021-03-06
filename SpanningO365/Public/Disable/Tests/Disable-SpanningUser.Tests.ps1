﻿Param (
    [String]$Module
)
BeforeAll{
    $functionName = (Get-Item $PSCommandPath ).BaseName.Replace(".Tests","")
    $ModuleData = Get-Module $Module
    $Function = $ModuleData.Invoke({Param($Module) Get-Command -Module $Module}, $Module) | Where-Object { $_.Name -eq $functionName}
    $Function | Out-Null # ToDo - Hide ScriptAnalyzer Scope Error
}
Describe 'Disable-SpanningUser Tests' -Tag "Structure" {

   Context 'Parameters for Disable-SpanningUser'{

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
            [String]$Function.Parameters.UserPrincipalName.ParameterSets.Keys | Should -Be '__AllParameterSets'
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
