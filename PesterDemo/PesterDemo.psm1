Write-Verbose "Importing Functions"

# Import everything in subfolders
foreach ( $folder in @( 'classes', 'private', 'public' ) )
{
    $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
    if ( Test-Path -Path $root )
    {
        Write-Verbose "processing folder $root"
        $files = Get-ChildItem -Path $root -Filter *.ps1 | Sort-Object Name

        # dot source each file
        $files | where-Object { $_.name -NotLike '*.Tests.ps1' } |
            ForEach-Object { Write-Verbose $_.name; . $_.FullName }
    }
}
