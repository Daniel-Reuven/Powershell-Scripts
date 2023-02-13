<#
    Define Directory path in parameter:
    $directory
#>

$directory = "<PATH>"

Get-ChildItem $directory -Recurse -Directory | Where-Object {!$_.GetFileSystemInfos().Count}