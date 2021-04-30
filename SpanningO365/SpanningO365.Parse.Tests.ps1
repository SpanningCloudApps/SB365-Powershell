BeforeDiscovery {
    $here = $PSScriptRoot

    $PrivateFunctions = Get-ChildItem "$here\Private\" -Filter '*.ps1' -Recurse | Where-Object {$_.name -NotMatch "Tests.ps1"}
    $PublicFunctions = Get-ChildItem "$here\Public\" -Filter '*.ps1' -Recurse | Where-Object {$_.name -NotMatch "Tests.ps1"}   
}

if ($PrivateFunctions.count -gt 0) {
    foreach($PrivateFunction in $PrivateFunctions) {
        Describe "Testing Private Function - $($PrivateFunction.BaseName) for Standard Processing" -ForEach @{ PrivateFunction = $PrivateFunction } {
        
            It "Is valid Powershell (Has no script errors)" {
                    $contents = Get-Content -Path $($PrivateFunction.FullName) -ErrorAction Stop
                    $errors = $null
                    $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
                    $errors.Count | Should -Be 0
            }
        } 
    }
}

if ($PublicFunctions.count -gt 0) {
    foreach($PublicFunction in $PublicFunctions) {
        Describe "Testing Public Function - $($PublicFunction.BaseName) for Standard Processing" -ForEach @{ PublicFunction = $PublicFunction } {
        
            It "Is valid Powershell (Has no script errors)" {
                    $contents = Get-Content -Path $PublicFunction.FullName -ErrorAction Stop
                    $errors = $null
                    $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
                    $errors.Count | Should -Be 0
            }
        }
    }
}

