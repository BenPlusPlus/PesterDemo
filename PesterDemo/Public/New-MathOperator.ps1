function New-MathOperator {
    <#
    .SYNOPSIS
        Returns an operator object for use with Invoke-MathCalculation.
    .DESCRIPTION
        Creates an instance of any supported mathematical operator for
        later use with the Invoke-MathCalculation cmdlet.
    .PARAMETER OperatorName
        The name of a supported operator.
    .EXAMPLE
        $mult = New-MathOperator Division
    #>
    [cmdletbinding()]
    param(
		[Parameter(Mandatory=$true)]
        [string]$OperatorName
    )

    try {
        $operator = New-Object -TypeName $OperatorName
        if ($operator) {
            # Verify that the created object has a definition in keeping with
            # our arbitrary standard.
            $member = $operator | Get-Member -Name 'Calculate' -MemberType 'Method' | where {$_.Definition -eq 'int Calculate(int X, int Y)'}
            if ($member) {
                return $operator
            }
        }
        throw 'Not a valid operator.'
    }
    catch {
        Write-Error "An operator of type '$OperatorName' could not be found."
        return $null
    }
}

