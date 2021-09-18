<#	
.NOTES
===========================================================================
 Created with: 	VSCode and PowerShell
 Created on:   	4/30/2021
 Author:    	Matthew McDermott
 Organization: 	Spanning Cloud Apps
 Filename:     	SpanningO365.Pester.Tests.ps1
===========================================================================
.DESCRIPTION

#Pester 5.1 Syntax
$params = @{Module = "SpanningO365"}
$container = New-PesterContainer -Path ".\SpanningO365.Pester5.Tests.ps1" -Data $params
Invoke-Pester -Container $container -Output Detailed -TagFilter "Structure", "Function"


#>

#Check for Module Dependencies
if (-not (Get-InstalledModule -Name Pester -ErrorAction SilentlyContinue)){
    Write-Warning -Message "You need Pester to run these tests."
    Exit
}

if (-not (Get-InstalledModule -Name PSScriptAnalyzer -ErrorAction SilentlyContinue)){
    Write-Warning -Message "You need PSScriptAnalyzer to run these tests."
    Exit
}

$testScore = @{
    FailedCount  = 0
    PassedCount  = 0
    SkippedCount = 0
    NotRunCount  = 0
    TotalCount   = 0
}

Import-Module .\SpanningO365.psm1

# Script Parser
$testResult = Invoke-Pester -Path .\SpanningO365.Parse.Tests.ps1 -Output Detailed -PassThru
$testScore.FailedCount  += $testResult.FailedCount
$testScore.PassedCount  += $testResult.PassedCount
$testScore.SkippedCount += $testResult.SkippedCount
$testScore.NotRunCount  += $testResult.NotRunCount
$testScore.TotalCount   += $testResult.TotalCount

# Structure and Functional
$params = @{Module = "SpanningO365"}
$container = New-PesterContainer -Path ".\Private\" -Data $params
$testResult = Invoke-Pester -Container $container -Output Detailed -TagFilter "Structure", "Functional" -PassThru
$testScore.FailedCount  += $testResult.FailedCount
$testScore.PassedCount  += $testResult.PassedCount
$testScore.SkippedCount += $testResult.SkippedCount
$testScore.NotRunCount  += $testResult.NotRunCount
$testScore.TotalCount   += $testResult.TotalCount

$container = New-PesterContainer -Path ".\Public\" -Data $params
$testResult = Invoke-Pester -Container $container -Output Detailed -TagFilter "Structure", "Functional" -PassThru
$testScore.FailedCount  += $testResult.FailedCount
$testScore.PassedCount  += $testResult.PassedCount
$testScore.SkippedCount += $testResult.SkippedCount
$testScore.NotRunCount  += $testResult.NotRunCount
$testScore.TotalCount   += $testResult.TotalCount

# ScriptAnalyser
$testResult = Invoke-Pester -Path .\SpanningO365.ScriptAnalyser.Tests.ps1 -Output Detailed -PassThru
$testScore.FailedCount  += $testResult.FailedCount
$testScore.PassedCount  += $testResult.PassedCount
$testScore.SkippedCount += $testResult.SkippedCount
$testScore.NotRunCount  += $testResult.NotRunCount
$testScore.TotalCount   += $testResult.TotalCount

$testScore
