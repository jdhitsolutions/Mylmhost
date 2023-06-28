Function Remove-LmhostsEntry {

    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Name')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ParameterSetName = 'Name',
            ValueFromPipelineByPropertyName
        )]
        [Alias('CN', 'Name')]
        [String]$Computername,
        [Parameter(
            Mandatory,
            ParameterSetName = 'IP',
            ValueFromPipelineByPropertyName
        )]
        [ValidatePattern('(\d{1,3}\.){3}\d{1,3}')]
        [String]$IPAddress
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"

        if (-not (Test-Path $lmfile )) {
            Write-Warning "No file found at $lmfile. Use Set-LmhostsEntry to add an entry."
            $Verified = $False
        }
        else {
            $Verified = $True
        }

    } #begin

    Process {
        If ($Verified) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Removing entry by $($PSCmdlet.ParameterSetName)"

            $FindParams = @{Raw = $True }
            Switch ($PSCmdlet.ParameterSetName) {
                'Name' {
                    $FindParams.Add('Computername', $PSBoundParameters.item('Computername'))
                } #computername

                'IP' {
                    $FindParams.Add('IPAddress', $PSBoundParameters.Item('IPAddress'))
                } #IP

            } #switch

            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Searching for entry"
            $entry = Get-LmhostsEntry @FindParams
            if ($entry) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating a backup file copy"
                Copy-Item -Path $lmfile -Destination $lmbackup
                $content = Get-Content -Path $lmfile
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Removing $get"
                ($content -replace $entry, '') | Out-File -FilePath $lmfile -Encoding ascii
            }

        } #if verified

    }# process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
