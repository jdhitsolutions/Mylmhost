Function Remove-LmhostsEntry {

[CmdletBinding(SupportsShouldProcess,DefaultParameterSetName="Name")]
Param(
[Parameter(Position=0,Mandatory,ParameterSetName="Name",ValueFromPipelineByPropertyName)]
[Alias("CN","Name")]
[String]$Computername,
[Parameter(Mandatory,ParameterSetName="IP",ValueFromPipelineByPropertyName)]
[ValidatePattern("(\d{1,3}\.){3}\d{1,3}")]
[String]$IPAddress
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.MyCommand)"  
    #display PSBoundParameters formatted nicely for Verbose output  
    [String]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[BEGIN  ] PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*4)$_"}) | Out-String) `n" 

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
        Write-Verbose "[PROCESS] Removing entry by $($PSCmdlet.ParameterSetName)"

        $findparams = @{Raw = $True}
        Switch ($PSCmdlet.ParameterSetName) {

            'Name'  {
                $findparams.Add("Computername",$PSBoundParameters.item("Computername"))
            } #computername
        
            'IP'          {
                $findparams.Add("IPAddress",$PSBoundParameters.Item("IPAddress"))
            } #IP

        } #switch

        Write-Verbose "Searching for entry"
        $entry = Get-LmhostsEntry @findparams
        if ($entry) {
            
            Write-Verbose "[PROCESS] Creating a backup file copy"
            Copy-Item -Path $lmfile -Destination $lmbackup
            $content = Get-Content -Path $lmfile
            Write-Verbose "[PROCESS] Removing $get"
            ($content -replace $entry,"") | Out-File -FilePath $lmfile -Encoding ascii
        }

        
    } #if verified

}# process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.MyCommand)"
} #end

}
