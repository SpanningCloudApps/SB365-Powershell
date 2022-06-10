BeforeAll {
    $here = $PSScriptRoot

    $PublicFunctionPath = "$here\Public\"
    $PrivateFunctionPath = "$here\Private\"
}
Describe 'ScriptAnalyzer Rule Testing' -Tag "ScriptAnalyzer" {
        
    Context 'Public Functions' {

        It 'Passes the Script Analyzer ' {
            (Invoke-ScriptAnalyzer -Path $PublicFunctionPath -Recurse -ExcludeRule PSUseProcessBlockForPipelineCommand, PSReviewUnusedParameter ).Count | Should -Be 0
        }
    }
     
     Context 'Private Functions' {

        It 'Passes the Script Analyzer ' {
            (Invoke-ScriptAnalyzer -Path $PrivateFunctionPath -Recurse -ExcludeRule PSUseProcessBlockForPipelineCommand, PSReviewUnusedParameter).Count | Should -Be 0
        }
    }
}
