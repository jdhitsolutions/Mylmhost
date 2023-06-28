
Get-ChildItem -path $PSScriptRoot\functions -Filter *.ps1 |
Foreach-Object { . $_.FullName}

#define variables for internal use. These are NOT exported.

#path to lmhosts file
$lmfile = "$env:windir\system32\drivers\etc\lmhosts"

#define a backup file variable
$lmbackup = "$env:windir\system32\drivers\etc\lmhosts.bak"

#IPv4 Regex pattern
[regex]$IPv4Pattern = "(?<IP>\b(\d{1,3}\.){3}\d{1,3}\b)\s+(?<Computername>\b\S+\b)"
