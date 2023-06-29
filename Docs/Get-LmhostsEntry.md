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
```
Get-LmhostsEntry [-Computername] <String> [-Raw]
```

### IP
```
Get-LmhostsEntry -IPAddress <String> [-Raw]
```

### All
```
Get-LmhostsEntry [-All] [-Raw]
```

## DESCRIPTION
Use this command to retrieve an entry from the lmhosts file. By default, the result will be written to the pipeline as an object. But you can use -Raw to display the entry as plain text.

## EXAMPLES

### Example 1
```
PS C:\> get-LmhostsEntry -Computername MyServer

Computername IPAddress
------------ ---------
MyServer     192.168.10.111
```

Get an entry by computername.

### Example 2
```
PS C:\> Get-LmhostsEntry -ipaddress 192.168.10.111

Computername IPAddress
------------ ---------
MyServer     192.168.10.111
```
Get an entry by IP address.

### Example 3
```
PS C:\> Get-LmhostsEntry myserver -raw

192.168.10.111  MyServer
```
Get the entry as plain text.

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
Aliases: CN,Name

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
Write matching text values from lmhosts file to the pipeline.

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

## INPUTS

### None

## OUTPUTS

### System.Object
### System.Text

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[Set-LmhostsEntry](Set-LmhostsEntry)
[Remove-LmhostsEntry](Remove-LmhostsEntry)
