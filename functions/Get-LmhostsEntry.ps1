Function Get-LmhostsEntry {
    [CmdletBinding(DefaultParameterSetName = 'Name')]
    [OutputType("lmHostsEntry")]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ParameterSetName = 'Name'
        )]
        [Alias('CN', 'Name')]
        [String]$Computername,
        [Parameter(Mandatory, ParameterSetName = 'IP')]
        [ValidatePattern('(\d{1,3}\.){3}\d{1,3}')]
        [String]$IPAddress,
        [Parameter(Mandatory, ParameterSetName = 'All')]
        [Switch]$All,
        [Switch]$Raw
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
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Get entry by $($PSCmdlet.ParameterSetName)"
            Switch ($PSCmdlet.ParameterSetName) {
                'Name' {
                    $find = $Computername
                }
                'IP' {
                    $find = $IPAddress
                }
                Default {
                    #get all entries
                }
            } #switch

            if ($all) {
                $data = Get-Content $lmfile | Select-String -Pattern '^[^#.*]'
                if ($raw) {
                    $IPv4Pattern.matches($data).value
                }
                else {
                    #create an object for each entry
                    $IPv4Pattern.matches($data).Captures |
                    ForEach-Object -Process {
                        [PSCustomObject]@{
                            PSTypeName   = 'lmhostsEntry'
                            Computername = $_.Groups['Computername']
                            IPAddress    = $_.Groups['IP']
                        }
                    } #foreach
                }
            } #get all
            else {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] ...$find"
                $entry =
                Get-Content -Path $lmfile | Select-String -Pattern $find -AllMatches
                if ($entry) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Found one or more matching entries"
                    if ($Raw) {
                        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Writing raw results to the pipeline"
                        #write the raw entry to the pipeline
                        $entry
                    }
                    else {
                        foreach ($item in $entry) {
                            #split into parts and write a new object to the pipeline
                            $m = $IPv4Pattern.Match($item)
                            [PSCustomObject]@{
                                PSTypeName   = 'lmhostsEntry'
                                Computername = $m.Groups['Computername'].value
                                IPAddress    = $m.Groups['IP'].value
                            }
                        } #foreach
                    } #else
                } #if entry found
                else {
                    Write-Warning "Entry for $($PSBoundParameters.values) not found."
                }
            } #else find single entry
        } #if verified
    }# process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
