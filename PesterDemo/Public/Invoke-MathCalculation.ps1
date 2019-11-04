function Invoke-MathCalculation {
    <#
    .SYNOPSIS
        Calculates the result of a mathematical operation on two integers.
    .DESCRIPTION
        Given a mathematical operator object and two integers, reports the
        output of the object.
    .PARAMETER MathOperation
        Any instance of a class which supplies a Calculate(x, y) method
        and returns an integer from that method.
    .PARAMETER X
        The first integer to be used in the calculation.
    .PARAMETER Y
        The second integer to be used in the equation.
    .EXAMPLE
        Invoke-MathCalculation -Operator $op -X 10 -Y 2
    #>
    [cmdletbinding()]
    param(
		[Parameter(Mandatory=$true)]
        [object]$Operator,
		[Parameter(Mandatory=$true)]
        [int]$X,
		[Parameter(Mandatory=$true)]
        [int]$Y
    )

    $result = $Operator.Calculate($X, $Y)

    [int]$answer = 0
    if ([int]::TryParse($result, [ref]$answer)) {
        Write-Host "The answer: $answer"
    }
    else {
        throw "The result of the operation could not be resolved to an integer data type."
    }
}

