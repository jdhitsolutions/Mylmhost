
@{

    RootModule           = 'Mylmhost.psm1'
    ModuleVersion        = '1.3.1'
    GUID                 = '8d9401f1-8423-4e76-aece-f743bf40ecf7'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2016-2017 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = "A set of commands for working with the legacy lmhosts file. If you don't have one, a new file will be created."
    PowerShellVersion    = '5.1'
    CompatiblePSEditions = 'Desktop'
    FunctionsToExport    = 'Get-LmhostsEntry', 'Remove-LmhostsEntry', 'Set-LmhostsEntry'
    PrivateData          = @{
        PSData = @{
            Tags         = @('networking', 'lmhosts')
            LicenseUri   = 'https://github.com/jdhitsolutions/Mylmhost/blob/master/LICENSE.txt'
            ProjectUri   = 'https://github.com/jdhitsolutions/Mylmhost'
            # IconUri = ''
            ReleaseNotes = 'https://github.com/jdhitsolutions/Mylmhost/blob/master/README.md'

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}


