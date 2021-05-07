Param (
    [String]$Module
)
BeforeAll{
    $functionName = (Get-Item $PSCommandPath ).BaseName.Replace(".Tests","")
    $ModuleData = Get-Module $Module
    $Function = $ModuleData.Invoke({Param($Module) Get-Command -Module $Module}, $Module) | Where-Object { $_.Name -eq $functionName}
    $Function | Out-Null # ToDo - Hide ScriptAnalyzer Scope Error
}
Describe 'Clear-SpanningAuthentication Tests' -Tag "Structure" {

   Context 'Parameters for Clear-SpanningAuthentication'{

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
