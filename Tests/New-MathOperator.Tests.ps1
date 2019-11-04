$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $moduleRoot -Leaf

. $projectRoot\$moduleName\Classes\Multiplication.ps1
. $projectRoot\$moduleName\Public\New-MathOperator.ps1

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
Describe "Create an instance of the requested operator" {
    Context "When requesting a valid operator type" {
        It "Returns the requested instance" {
            $op = New-MathOperator -OperatorName Multiplication
            $op | Should -Not -BeNullOrEmpty
            $op.Calculate(40, 10) | Should -Be 400
        }
    }

    Context "When requesting a type that lacks a Calculate() method" {
        It "Reports an error" {
            $Error.Clear()
            $op = New-MathOperator -OperatorName Hashtable -ErrorAction SilentlyContinue
            $op | Should -BeNullOrEmpty
            $Error.Count | Should -BeGreaterThan 0
        }
    }

    Context "When requesting a type that contains the wrong definition for Calculate()" {
        It "Reports an error" {
            $Error.Clear()
            $op = New-MathOperator -OperatorName RogueOperator -ErrorAction SilentlyContinue
            $op | Should -BeNullOrEmpty
            $Error.Count | Should -BeGreaterThan 0
        }
    }

    Context "When requesting a type that doesn't exist" {
        It "Reports an error" {
            $Error.Clear()
            $op = New-MathOperator -OperatorName ASDFASDFASDFASDF -ErrorAction SilentlyContinue
            $op | Should -BeNullOrEmpty
            $Error.Count | Should -BeGreaterThan 0
        }
    }

}
