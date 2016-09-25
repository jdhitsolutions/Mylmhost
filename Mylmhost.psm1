#requires -version 5.0

#region Main

Function Get-LmhostsEntry {
[cmdletbinding(DefaultParameterSetName="Name")]
Param(
[Parameter(Position=0,Mandatory,ParameterSetName="Name")]
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
   [string]$pb = ($PSBoundParameters | format-table -AutoSize | Out-String).TrimEnd()
   Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*4)$_"}) | out-string) `n" 

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
            $data = get-content $lmfile | sls "^[^#.*]"
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
            $entry = Get-Content -Path $lmfile | select-string $find | Select -last 1
            if ($entry) {
                Write-Verbose "[PROCESS] Found: $entry"
                if ($Raw) {
                    #write the raw entry to the pipeline
                    $entry
                }
                else {
                #split into parts and write a new object to the pipeline
                $m= $IPv4Pattern.Match($entry)
                [pscustomobject]@{
                    Computername = $m.Groups["Computername"].value
                    IPAddress = $m.Groups["IP"].value
                }
               }
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
[Parameter(Position=0,Mandatory,ParameterSetName="Name")]
[string]$Computername,
[Parameter(Mandatory,ParameterSetName="IP")]
[ValidatePattern("(\d{1,3}\.){3}\d{1,3}")]
[string]$IPAddress
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | format-table -AutoSize | Out-String).TrimEnd()
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
[Parameter(Mandatory)]
[string]$Computername,
[Parameter(Mandatory)]
[ValidatePattern("(\d{1,3}\.){3}\d{1,3}")]
[string]$IPAddress,
[switch]$Passthru
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"     
    if (-not (Test-Path $lmfile )) {
      Write-Verbose "[BEGIN  ] Creating a new lmhosts file: $lmfile"
      Set-Content -Value "#lmhosts file for resolving NETBIOS names `n" -Path $lmfile
    }

} #begin

Process {

    $entry = "$IPAddress  $Computername"
            
    Write-Verbose "[PROCESS] Check for existing entry $entry"
    #There should only be one or at least we'll only process one
    $existing = Get-Content -Path $lmfile | select-string $Computername | Select -last 1

    if ($existing) {
        [string]$line = $existing.Line
        Write-Verbose "[PROCESS] Processing existing entry: $line"
        
        $m = $IPv4Pattern.Match($line)
        $OldComputername = $m.Groups["Computername"].value
        $oldIP = $m.Groups["IP"].value
         Write-Verbose "Existing Computername = $oldComputername"
         Write-Verbose "Existing IPAddress = $oldIP"   
        if (($oldIP -eq $IPAddress) -and ($OldComputername -eq $Computername)) {
            Write-Host "The Computername and IP address matches the current entry. No changes needed." -ForegroundColor Magenta
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

#define exported variables
$lmfile = "$env:windir\system32\drivers\etc\lmhosts"
#define a backup file variable
$lmbackup = "$env:windir\system32\drivers\etc\lmhosts.bak"
#IPv4 Regex pattern
[regex]$IPv4Pattern = "(?<IP>\b(\d{1,3}\.){3}\d{1,3}\b)\s+(?<Computername>\b\S+\b)"

#define aliases

#export module members if not using a manifest
Export-ModuleMember -Function 'Get-LmhostsEntry','Remove-LmhostsEntry','Set-LmhostsEntry' -Variable 'lmfile','lmbackup','IPv4Pattern'