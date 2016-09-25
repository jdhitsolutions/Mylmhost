# MyLMHost #

This PowerShell module contains a set of functions for working with the legacy lmhosts file.

The purpose of this file was to provide name resolution for Netbios computernames. Normally, this file is irrelevant in today's networking but remains as a legacy artifact. If you do not have a file already created, one will be the first time you run Set-LmhostsEntry.

## Why?
There may be a few scenarios where using lmhosts still has value. You can use this file to provide name resolution for a computer that otherwise can't be resolved. For example, if you are running a virtual machine on a private or NAT'd network, you can't normally resolve the name from the host. But by adding an lmhosts entry, you can.

## Commands

* Get-LmhostsEntry
* Remove-LmhostsEntry
* Set-LmhostsEntry

The commands will write a custom object to the pipeline based on the computername and IP address.

## Example

    PS C:\> Get-LmhostsEntry chi-dc01

    Computername IPAddress
    ------------ ---------
    chi-dc01     172.16.30.200


## Limitations
It is assumed that your lmhosts file is well formed and that you do not have duplicate computer names and IP address. It is also assumed that any comments, using the # character, start at the beginning of the line.

These commands do not take into account any directives like INCLUDE, #PRE OR #DOM.

_last updated 25 September 2016_
