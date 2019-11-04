$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

. $projectRoot\$moduleName\Classes\Division.ps1

Describe "Perform division operations" {
    $operator = [Division]::new()

    Context "When given numbers that can be divided" {
        It "Reports that 100 / 2 is 50" {
            $operator.Calculate(100, 2) | Should -Be 50
        }
        It "Reports that 2 / 2 is 1" {
            $operator.Calculate(2, 2) | Should -Be 1
        }
    }

    Context "When given an invalid denominator" {
        It "Throws an error" {
            $Error.Clear()
            try {
                $operator.Calculate(2, 0)
            }
            catch {
                # whoops
            }
            $Error.Count | Should -Be 1
        }
    }
}

