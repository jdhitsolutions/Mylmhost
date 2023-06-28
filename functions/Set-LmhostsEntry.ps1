Function Set-LmhostsEntry {

    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CN', 'Name')]
        [String]$Computername,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidatePattern('(\d{1,3}\.){3}\d{1,3}')]
        [String]$IPAddress,
        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"
        if (-not (Test-Path -Path $lmfile )) {
            Write-Verbose "[BEGIN  ] Creating a new lmhosts file: $lmfile"
            Set-Content -Value "#lmhosts file for resolving NETBIOS names `n" -Path $lmfile -Encoding Ascii
        }

    } #begin

    Process {
        $entry = "$IPAddress  $Computername"

        Write-Verbose "[PROCESS] Check for existing entry $entry"
        #There should only be one or at least we'll only process one
        $existing = Get-Content -Path $lmfile | Select-String $Computername | Select-Object -Last 1

        if ($existing) {
            [String]$line = $existing.Line
            Write-Verbose "[PROCESS] Processing existing entry: $line"

            $m = $IPv4Pattern.Match($line)
            $OldComputername = $m.Groups['Computername'].value
            $oldIP = $m.Groups['IP'].value
            Write-Verbose "Existing Computername = $oldComputername"
            Write-Verbose "Existing IPAddress = $oldIP"
            if (($oldIP -eq $IPAddress) -and ($OldComputername -eq $Computername)) {
                Write-Warning 'The Computername and IP address matches the current entry. No changes needed.'
                #exit
                Return
            }
            else {
                #modify the line
                $Replace = $True
            }
        } #if existing

        #create a backup copy of the file
        Write-Verbose '[PROCESS] Creating a backup file copy'
        Copy-Item -Path $lmfile -Destination $lmbackup

        #insert the line
        if ($Replace) {
            $content = Get-Content -Path $lmfile
            Write-Verbose "[PROCESS] Replacing $oldIP with $Ipaddress"
        ($content -replace $line, $entry) | Out-File -FilePath $lmfile -Encoding ascii
        }
        else {
            #insert at the end
            Write-Verbose "[PROCESS] Appending $entry"
            $entry | Out-File -FilePath $lmfile -Append -Encoding ascii
        }

        If ($PassThru) {
            Get-LmhostsEntry -Computername $Computername
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
