# MyLMHost

[![PSGallery Version](https://img.shields.io/powershellgallery/v/Mylmhost.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/Mylmhost/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/Mylmhost.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/Mylmhost/)

This PowerShell module contains a set of functions for working with the legacy lmhosts file (%windir%\system32\drivers\etc\lmhosts). Note that the file **does not** have an extension.

The module should work on Windows systems running Windows PowerShell 5.1 or PowerShell 7. Install from the PowerShell Gallery.

```powershell
Install-Module mylmhost
```

## Why?

The purpose of this file was to provide name resolution for Netbios computer names. Normally, this file is irrelevant in today's networking but remains a legacy artifact. If you do not have a file already created, one will be generated the first time you run `Set-LmhostsEntry`.

There may be a few scenarios where using lmhosts still has value. You can use this file to provide name resolution for a computer that otherwise can't be resolved. For example, if you are running a virtual machine on a private or NAT'd network, you can't normally resolve the name from the host. But by adding an lmhosts entry, you can.

## Commands

* [Get-LmhostsEntry](.\docs\Get-LmHostsEntry.md)
* [Remove-LmhostsEntry](.\docs\Remove-LmhostsEntry.md)
* [Set-LmhostsEntry](.\docs\Set-LmhostsEntry.md)
* [Open-LmhostsFile](.\docs\Open-LmhostsFile.md)

The commands will write a custom object to the pipeline based on the computer name and IP address.

## Examples

To add an entry, specify the computer's NETBIOS name and its IPv4 address.

```powershell
Set-LmhostsEntry -Computername chi-dc01 -IPAddress 172.16.30.200
```

If you don't have an existing lmhosts file, it will be created.

Getting the lmhosts entry is easy.

```powershell
PS C:\> Get-LmhostsEntry chi-dc01

Computername IPAddress
------------ ---------
chi-dc01     172.16.30.200
```

It is equally easy to remove an entry.

```powershell
Remove-LmhostsEntry -Computername SRV02
```

You could easily import a CSV file of entries to populate the lmhosts file.

```powershell
PS C:\> import-csv C:\scripts\lmentries.csv | Set-LmhostsEntry -PassThru

Computername IPAddress
------------ ---------
chi-dc01     192.168.3.200
chi-dc04     192.168.3.203
chi-core01   192.168.3.204
chi-hvr1     192.168.3.205
chi-fp02     192.168.3.210
chi-fp03     192.168.3.211
```

## Limitations

It is assumed that your lmhosts file is well formed and that you do not have duplicate computer names and IP addresses. It is also assumed that any comments, using the # character, start at the beginning of the line.

These commands **do not** take into account any directives like `INCLUDE`, `#PRE`, OR `#DOM`.
