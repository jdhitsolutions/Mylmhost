---
external help file: Mylmhost-help.xml
online version:
schema: 2.0.0
---

# Set-LmhostsEntry

## SYNOPSIS

Add or modify an lmhosts entry.

## SYNTAX

```yaml
Set-LmhostsEntry [-Computername] <String> [-IPAddress] <String> [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to modify an existing entry in the lmhosts file. You must specify both the computername and IP Address. If the entry already exists the command will end. Otherwise it will modify the entry with the specified computername or IP address.

If no entry is found then one will be created.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-LmhostsEntry -Computername MyServer -IPAddress 192.168.10.100 -Passthru

Computername IPAddress
------------ ---------
MyServer     192.168.10.100
```

Create a new lmhosts entry.

### Example 2

```powershell
PS C:\> Set-LmhostsEntry -Computername MyServer -IPAddress 192.168.10.111 -Passthru

Computername IPAddress
------------ ---------
MyServer     192.168.10.111
```

Modify an existing entry with a new IP address.

## PARAMETERS

### -Computername

The computer's NETBIOS name.

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Passthru

Write the updated object back to the pipeline.

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

### -Confirm

Prompts you for confirmation before running the command.

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

Shows what would happen if the command runs.

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

### System.string

## OUTPUTS

### None

### lmhostsEntry

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-LmhostsEntry](Get-LmhostsEntry.md)

[Remove-LmhostsEntry](Remove-LmhostsEntry.md)
