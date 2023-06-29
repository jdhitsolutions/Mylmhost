---
external help file: Mylmhost-help.xml
online version: 
schema: 2.0.0
---

# Remove-LmhostsEntry
## SYNOPSIS
Remove an entry from the lmhosts file.

## SYNTAX

### Name (Default)
```
Remove-LmhostsEntry [-Computername] <String> [-WhatIf] [-Confirm]
```

### IP
```
Remove-LmhostsEntry -IPAddress <String> [-WhatIf] [-Confirm]
```

## DESCRIPTION
Use this command to delete an entry from the lmhosts file. You can specify the entry by name or IP address.

## EXAMPLES

### Example 1
```
PS C:\> Remove-LmhostsEntry Myserver
```

Remove an entry by computername.

### Example 2
```
PS C:\> Remove-LmhostsEntry -ipaddress 192.168.10.111
```

Remove an entry by IP address.

## PARAMETERS

### -Computername
The computer's NETBIOS name.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### None

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[Get-LmhostsEntry](Get-LmhostsEntry)
[Set-LmhostsEntry](Set-LmhostsEntry)

