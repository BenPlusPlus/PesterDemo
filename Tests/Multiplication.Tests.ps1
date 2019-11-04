$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

. $projectRoot\$moduleName\Classes\Multiplication.ps1

Describe "Perform multiplication operations" {
    $operator = [Multiplication]::new()

    It "Reports that 2 * 2 is 4" {
        $operator.Calculate(2, 2) | Should -Be 4
    }
    It "Reports that 2 * 27 is 54" {
        $operator.Calculate(2, 27) | Should -Be 54
    }
}

