#Module manifest for module 'Mylmhost'
@{

    RootModule           = 'Mylmhost.psm1'
    ModuleVersion        = '1.4.0'
    GUID                 = '8d9401f1-8423-4e76-aece-f743bf40ecf7'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2016-2023 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = "A set of PowerShell commands for working with the legacy lmhosts file. If you don't have one, a new file will be created."
    PowerShellVersion    = '5.1'
    CompatiblePSEditions = 'Desktop','Core'
    FunctionsToExport    = 'Get-LmhostsEntry', 'Remove-LmhostsEntry', 'Set-LmhostsEntry','Open-LmHosts'
    PrivateData          = @{
        PSData = @{
            Tags         = @('networking', 'lmhosts')
            LicenseUri   = 'https://github.com/jdhitsolutions/Mylmhost/blob/master/LICENSE.txt'
            ProjectUri   = 'https://github.com/jdhitsolutions/Mylmhost'
            ReleaseNotes = 'https://github.com/jdhitsolutions/Mylmhost/blob/master/README.md'

        } # End of PSData hashtable

    } # End of PrivateData hashtable

}


