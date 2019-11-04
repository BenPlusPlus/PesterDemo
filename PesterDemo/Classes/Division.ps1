class Division {
    [int]Calculate([int]$X, [int]$Y) {
        if ($Y -eq 0) {
            throw 'Cannot divide by zero.'
        }
        return $X / $Y
    }
}

