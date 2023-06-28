---
external help file: Mylmhost-help.xml
online version:
schema: 2.0.0
---

# Get-LmhostsEntry

## SYNOPSIS

Get an entry from the lmhosts file.

## SYNTAX

### Name (Default)

```yaml
Get-LmhostsEntry [-Computername] <String> [-Raw] [<CommonParameters>]
```

### IP

```yaml
Get-LmhostsEntry -IPAddress <String> [-Raw] [<CommonParameters>]
```

### All

```yaml
Get-LmhostsEntry [-All] [-Raw] [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve an entry from the lmhosts file. By default, the result will be written to the pipeline as an object. But you can use -Raw to display the entry as plain text.

## EXAMPLES

### Example 1

```powershell
PS C:\> get-LmhostsEntry -Computername MyServer

Computername IPAddress
------------ ---------
MyServer     192.168.10.111
```

Get an entry by computername.

### Example 2

```powershell
PS C:\> Get-LmhostsEntry -ipaddress 192.168.10.111

Computername IPAddress
------------ ---------
MyServer     192.168.10.111
```

Get an entry by IP address.

### Example 3

```powershell
PS C:\> Get-LmhostsEntry myserver -raw

192.168.10.111  MyServer
```

Get the entry as plain text.

### Example 4

```powershell
PS C:\> Get-LmhostsEntry -Computername "\d{2}$"

Computername IPAddress
------------ ---------
Fooby23      10.100.101.23
chi-dc01     192.168.3.200
chi-dc04     192.168.3.203
chi-core01   192.168.3.204
chi-fp02     192.168.3.210
chi-fp03     192.168.3.211
```

Use a regex pattern to find all entries where the computername ends with two digits.

### Example 5

```powershell
PS C:\> Get-LmhostsEntry -Computername chi-fp

Computername IPAddress
------------ ---------
chi-fp02     192.168.3.210
chi-fp03     192.168.3.211
```

Find all entries where the computername starts with 'chi-fp'.

## PARAMETERS

### -All

Get all lmhosts entries.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Computername

The computer's NETBIOS name. Wildcards aren't really supported but you can use a regular expression pattern.

```yaml
Type: String
Parameter Sets: Name
Aliases: CN, Name

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPAddress

The IPv4 Address.

```yaml
Type: String
Parameter Sets: IP
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw

Write matching text values from the lmhosts file to the pipeline. This will write a MatchInfo object to the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### lmHostsEntry

### Microsoft.PowerShell.Commands.MatchInfo

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-LmhostsEntry](Set-LmhostsEntry.md)

[Remove-LmhostsEntry](Remove-LmhostsEntry.md)
