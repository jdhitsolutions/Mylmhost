Function Open-LmHosts {
    [cmdletbinding()]
    [OutputType('None')]
    [alias('lmhosts')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Specify the application to open the lmhosts file with. Default is notepad.exe"
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Notepad","VSCode","ISE")]
        [String]$Editor = "Notepad"
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        if (Test-Path $lmfile) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Opening $lmfile in $Editor"
            Switch ($Editor) {
                "notepad" {
                    notepad.exe $lmfile
                }

                "VSCode" {
                    code $lmfile
                }
                "ISE" {
                    PowerShell_ise.exe $lmfile
                }
            }
        } #if Test-Path
        else {
            Write-Warning "Failed to find $lmfile. Use Set-LmhostsEntry to create a new file."
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Open-LmHosts