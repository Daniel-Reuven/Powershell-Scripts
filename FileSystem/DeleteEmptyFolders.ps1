<#
    A script block (anonymous function) that will remove empty folders under a root folder, using tail-recursion to ensure that it only
    walks the folder tree once. -Force is used to be able to process hidden files/folders as well.
    Define Directory path in parameter:
    $directory
#>
$directory = "<PATH>"

$tailRecursion = {
    param(
        $Path
    )
    foreach ($childDirectory in Get-ChildItem -Force -LiteralPath $Path -Directory) {
        & $tailRecursion -Path $childDirectory.FullName
    }
    $currentChildren = Get-ChildItem -Force -LiteralPath $Path
    $isEmpty = $currentChildren -eq $null
    if ($isEmpty) {
        Write-Verbose "Removing empty folder at path '${Path}'." -Verbose
        Remove-Item -Force -LiteralPath $Path
    }
}

& $tailRecursion -Path $directory