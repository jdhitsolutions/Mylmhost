#requires -version 5.0.0.0

#region Main

Function Get-LmhostsEntry {
[cmdletbinding(DefaultParameterSetName="Name")]
Param(
[Parameter(Position=0,Mandatory,ParameterSetName="Name")]
[Alias("CN","Name")]
[string]$Computername,
[Parameter(Mandatory,ParameterSetName="IP")]
[ValidatePattern("(\d{1,3}\.){3}\d{1,3}")]
[string]$IPAddress,
[Parameter(Mandatory,ParameterSetName="All")]
[switch]$All,
[switch]$Raw
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    #display PSBoundparameters formatted nicely for Verbose output  
   [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
   Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*4)$_"}) | Out-String) `n" 

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
        Write-Verbose "[PROCESS] Get entry by $($PSCmdlet.ParameterSetName)"
        Switch ($PSCmdlet.ParameterSetName) {

        "Name" {
            $find = $Computername
          }
        "IP" {
            $find = $IPAddress
         }
         Default {
            #get all entries
         }
        } #switch

        if ($all) {
            $data = Get-Content $lmfile | Select-String -pattern "^[^#.*]"
            if ($raw) {
                $IPv4Pattern.matches($data).value
            }
            else {
              #create an object for each entry
              $IPv4Pattern.matches($data).Captures | 
              foreach {
                [pscustomobject]@{
                    Computername = $_.Groups["Computername"]
                    IPAddress = $_.Groups["IP"]
                }
              } #foreach
            }
        } #get all 
        else {
            Write-Verbose "[PROCESS] ...$find"
            $entry = 
            Get-Content -Path $lmfile | Select-String -pattern $find -AllMatches
            if ($entry) {
                Write-Verbose "[PROCESS] Found one or more matching entries"
                if ($Raw) {
                    Write-Verbose "[PROCESS] Writing raw results to the pipeline"
                    #write the raw entry to the pipeline
                    $entry
                }
                else {
                    foreach ($item in $entry) {
                      #split into parts and write a new object to the pipeline
                      $m = $IPv4Pattern.Match($item)
                     [pscustomobject]@{
                        Computername = $m.Groups["Computername"].value
                        IPAddress = $m.Groups["IP"].value
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
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end
} #close Get

Function Remove-LmhostsEntry {

[cmdletbinding(SupportsShouldProcess,DefaultParameterSetName="Name")]
Param(
[Parameter(Position=0,Mandatory,ParameterSetName="Name",ValueFromPipelineByPropertyName)]
[Alias("CN","Name")]
[string]$Computername,
[Parameter(Mandatory,ParameterSetName="IP",ValueFromPipelineByPropertyName)]
[ValidatePattern("(\d{1,3}\.){3}\d{1,3}")]
[string]$IPAddress
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*4)$_"}) | Out-String) `n" 

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
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #close Remove

Function Set-LmhostsEntry {

[cmdletbinding(SupportsShouldProcess)]
Param(
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[Alias("CN","Name")]
[string]$Computername,
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ValidatePattern("(\d{1,3}\.){3}\d{1,3}")]
[string]$IPAddress,
[switch]$Passthru
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"     
    if (-not (Test-Path $lmfile )) {
      Write-Verbose "[BEGIN  ] Creating a new lmhosts file: $lmfile"
      Set-Content -Value "#lmhosts file for resolving NETBIOS names `n" -Path $lmfile -Encoding Ascii
    }

} #begin

Process {

    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[PROCESS] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 
    
    $entry = "$IPAddress  $Computername"
            
    Write-Verbose "[PROCESS] Check for existing entry $entry"
    #There should only be one or at least we'll only process one
    $existing = Get-Content -Path $lmfile | Select-String $Computername | Select -last 1

    if ($existing) {
        [string]$line = $existing.Line
        Write-Verbose "[PROCESS] Processing existing entry: $line"
        
        $m = $IPv4Pattern.Match($line)
        $OldComputername = $m.Groups["Computername"].value
        $oldIP = $m.Groups["IP"].value
         Write-Verbose "Existing Computername = $oldComputername"
         Write-Verbose "Existing IPAddress = $oldIP"   
        if (($oldIP -eq $IPAddress) -and ($OldComputername -eq $Computername)) {
            Write-Host -foreground Green "The Computername and IP address matches the current entry. No changes needed." -ForegroundColor Magenta
            #exit
            Return
        }
        else {
            #modify the line           
            $Replace = $True
        }
    } #if existing

    #create a backup copy of the file
    Write-Verbose "[PROCESS] Creating a backup file copy"
    Copy-Item -Path $lmfile -Destination $lmbackup

    #insert the line
    if ($Replace) {
        $content = Get-Content -Path $lmfile
        Write-Verbose "[PROCESS] Replacing $oldIP with $Ipaddress"
        ($content -replace $line,$entry) | Out-File -FilePath $lmfile -Encoding ascii
    }
    else {
        #insert at the end
        Write-Verbose "[PROCESS] Appending $entry"
        $entry | Out-File -FilePath $lmfile -Append -Encoding ascii        
    }

    If ($Passthru) {
        Get-LmhostsEntry -Computername $Computername
     }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end
} #close Set

#endregion


#define variables for internal use. These are not exported

#path to lmhosts file
$lmfile = "$env:windir\system32\drivers\etc\lmhosts"

#define a backup file variable
$lmbackup = "$env:windir\system32\drivers\etc\lmhosts.bak"

#IPv4 Regex pattern
[regex]$IPv4Pattern = "(?<IP>\b(\d{1,3}\.){3}\d{1,3}\b)\s+(?<Computername>\b\S+\b)"


