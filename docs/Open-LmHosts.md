---
external help file: Mylmhost-help.xml
Module Name: Mylmhost
online version:
schema: 2.0.0
---

# Open-LmHosts

## SYNOPSIS

Open the lmhosts file in your editor

## SYNTAX

```yaml
Open-LmHosts [[-Editor] <String>] [<CommonParameters>]
```

## DESCRIPTION

This is a simple command to open the lmhosts file in the editor of your choice. The default is Notepad.

## EXAMPLES

### Example 1

```powershell
PS C:\> Open-LmHosts
```

Open the file in Notepad.

### Example 2

```powershell
PS C:\> Open-LmHosts -Editor VSCode
```

Open the file in VSCode.

## PARAMETERS

### -Editor

Specify the application to open the lmhosts file with.
Default is notepad.exe

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Notepad, VSCode, ISE

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
