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

```yaml
Remove-LmhostsEntry [-Computername] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### IP

```yaml
Remove-LmhostsEntry -IPAddress <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to delete an entry from the lmhosts file. You can specify the entry by name or IP address. If you want to remove multiple entries, use Get-LmhostsEntry to retrieve the entries and pipe them to Remove-LmhostsEntry. See examples.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-LmhostsEntry ServerXXY
```

Remove an entry by computername.

### Example 2

```powershell
PS C:\> Remove-LmhostsEntry -ipaddress 192.168.10.111
```

Remove an entry by IP address.

### Example 3

```powershell
PS C:\> Get-LmhostsEntry -Computername chi-fp | Remove-LmhostsEntry
```

Get entries that start with chi-fp and remove them.

## PARAMETERS

### -Computername

The computer's NETBIOS name.

```yaml
Type: String
Parameter Sets: Name
Aliases: CN, Name

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### None

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-LmhostsEntry](Get-LmhostsEntry.md)

[Set-LmhostsEntry](Set-LmhostsEntry.md)
