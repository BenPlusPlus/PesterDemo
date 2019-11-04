$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

. $projectRoot\$moduleName\Classes\Multiplication.ps1
. $projectRoot\$moduleName\Public\Invoke-MathCalculation.ps1

#
# Test scaffolding
#
class RogueOperator {
    [string]Calculate([int]$X, [int]$Y) {
        return "No numbers here!"
    }
}

#
# Main testing logic
#
Describe "Run calculations given an operator" {
    # Use this to store the written result of the
    # Invoke-MathCalculation call.
    $output = @{value=$null}
    Mock Write-Host { $output.value = $Object }

    Context "When given a Multiplication operator" {
        $operator = [Multiplication]::new()

        It "Should return a correct answer" {
            Invoke-MathCalculation -Operator $operator -X 10 -Y 7
            Assert-MockCalled 'Write-Host' -Times 1
            $output.value.EndsWith('answer: 70') | Should -BeTrue
        }
    }

    Context "When given an operator object that returns an invalid result" {
        $operator = [RogueOperator]::new()

        It "Should throw an error" {
            { Invoke-MathCalculation -Operator $operator -X 10 -Y 7 } | Should -Throw
        }
    }
}

