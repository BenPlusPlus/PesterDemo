# PesterDemo

This project is a simple PowerShell module that demonstrates a few basic concepts in relation to using the Pester framework for automated testing.

## Prerequisites

Make sure the Pester framework is installed on your computer. You can install it with the following PowerShell command:

```powershell
Install-Module -Name Pester -Force
```

## Running the automated tests

From a PowerShell prompt, switch to the root project folder (the one with this README in it) and run:

```powershell
Invoke-Pester
```

You'll receive a report of all tests run and the pass/fail tally.

## Running the module

Copy the ```PesterDemo``` folder from the root project folder (not the top-level folder itself) to one of your local PowerShell Modules folders. The simplest target location would be ```%userprofile%\Documents\WindowsPowerShell\Modules```.

Then, from a PowerShell prompt, you should be able to execute:

```powershell
Import-Module PesterDemo
$operator = New-MathOperator Multiplication
Invoke-MathCalculation -Operator $operator -X 10 -Y 10
```
