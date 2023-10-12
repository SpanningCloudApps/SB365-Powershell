#
# Module manifest for module 'SpanningO365'
#
# Generated by: Spanning Cloud Apps
#
# Generated on: 11/3/2018
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule = '.\SpanningO365.psm1'
    
    # Version number of this module.
    ModuleVersion = '4.5.0.0'
    
    # Supported PSEditions
    # CompatiblePSEditions = @()
    
    # ID used to uniquely identify this module
    GUID = '2029a86b-b4ef-4306-83f0-aac212dbee83'
    
    # Author of this module
    Author = 'Spanning Cloud Apps'
    
    # Company or vendor of this module
    CompanyName = 'Spanning Cloud Apps'
    
    # Copyright statement for this module
    Copyright = '(c) 2018-22 Spanning Cloud Apps. All rights reserved.'
    
    # Description of the functionality provided by this module
    Description = 'Spanning Backup for Office 365 REST API PowerShell Module provides PowerShell access to manage user licenses and get user and tenant information.'
    
    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = '3.0'
    
    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = '3.0'
    
    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = '3.0'
    
    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''
    
    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''
    
    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''
    
    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()
    
    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()
    
    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()
    
    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()
    
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()
    
    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()
    
    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = 'Get-SpanningAuthentication','Clear-SpanningAuthentication', `
                        'Get-SpanningTenantInfo','Get-SpanningUser','Enable-SpanningUser','Enable-SpanningUserList', `
                        'Get-SpanningUsers','Disable-SpanningUser','Get-SpanningAdmins','Get-SpanningNonAdmins','Disable-SpanningUserList', `
                        'Get-SpanningAssignedUsers','Get-SpanningUnassignedUsers','Get-SpanningTenantInfoPaymentStatus', 'Get-SpanningTenantBackupSummary', `
                        'Enable-SpanningUsersFromCSVAdvanced','Disable-SpanningUsersFromCSVAdvanced'
    
    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = ''
    
    # Variables to export from this module
    VariablesToExport = ''
    
    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = ''
    
    # DSC resources to export from this module
    # DscResourcesToExport = @()
    
    # List of all modules packaged with this module
    # ModuleList = @()
    
    # List of all files packaged with this module
    # FileList = @()
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
    
        PSData = @{
    
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()
    
            # A URL to the license for this module.
            # LicenseUri = ''
    
            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/SpanningCloudApps/SB365-Powershell'
    
            # A URL to an icon representing this module.
            # IconUri = ''
    
            # ReleaseNotes of this module
            # ReleaseNotes = ''
    
        } # End of PSData hashtable
    
    } # End of PrivateData hashtable
    
    # HelpInfo URI of this module
    # HelpInfoURI = ''
    
    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
    
    }
    