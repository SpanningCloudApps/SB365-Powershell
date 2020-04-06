Describe 'Get-SpanningAuthentication Tests' {

   Context 'Parameters for Get-SpanningAuthentication'{

        It 'Has a Parameter called ApiToken' {
            $Function.Parameters.Keys.Contains('ApiToken') | Should Be 'True'
            }
        It 'ApiToken Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.ApiToken.Attributes.Mandatory | Should be 'False'
            }
        It 'ApiToken Parameter is of String Type' {
            $Function.Parameters.ApiToken.ParameterType.FullName | Should be 'System.String'
            }
        It 'ApiToken Parameter is member of ParameterSets' {
            [String]$Function.Parameters.ApiToken.ParameterSets.Keys | Should Be '__AllParameterSets'
            }
        It 'ApiToken Parameter Position is defined correctly' {
            [String]$Function.Parameters.ApiToken.Attributes.Position | Should be '0'
            }
        It 'Does ApiToken Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.ApiToken.Attributes.ValueFromPipeline | Should be 'True'
            }
        It 'Does ApiToken Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.ApiToken.Attributes.ValueFromPipelineByPropertyName | Should be 'True'
            }
        It 'Does ApiToken Parameter use advanced parameter Validation? ' {
            $Function.Parameters.ApiToken.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should Be 'False'
            $Function.Parameters.ApiToken.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should Be 'False'
            $Function.Parameters.ApiToken.Attributes.TypeID.Name -contains 'ValidateScript' | Should Be 'False'
            $Function.Parameters.ApiToken.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should Be 'False'
            $Function.Parameters.ApiToken.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should Be 'False'
            }
        It 'Has Parameter Help Text for ApiToken '{
            $function.Definition.Contains('.PARAMETER ApiToken') | Should Be 'True'
            }
        It 'Has a Parameter called Region' {
            $Function.Parameters.Keys.Contains('Region') | Should Be 'True'
            }
        It 'Region Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.Region.Attributes.Mandatory | Should be 'False'
            }
        It 'Region Parameter is of String Type' {
            $Function.Parameters.Region.ParameterType.FullName | Should be 'System.String'
            }
        It 'Region Parameter is member of ParameterSets' {
            [String]$Function.Parameters.Region.ParameterSets.Keys | Should Be '__AllParameterSets'
            }
        It 'Region Parameter Position is defined correctly' {
            [String]$Function.Parameters.Region.Attributes.Position | Should be '1'
            }
        It 'Does Region Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.Region.Attributes.ValueFromPipeline | Should be 'True'
            }
        It 'Does Region Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.Region.Attributes.ValueFromPipelineByPropertyName | Should be 'True'
            }
        It 'Does Region Parameter use advanced parameter Validation? ' {
            $Function.Parameters.Region.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should Be 'False'
            $Function.Parameters.Region.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should Be 'False'
            $Function.Parameters.Region.Attributes.TypeID.Name -contains 'ValidateScript' | Should Be 'False'
            $Function.Parameters.Region.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should Be 'False'
            $Function.Parameters.Region.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should Be 'False'
            }
        It 'Has Parameter Help Text for Region '{
            $function.Definition.Contains('.PARAMETER Region') | Should Be 'True'
            }
        It 'Has a Parameter called AdminEmail' {
            $Function.Parameters.Keys.Contains('AdminEmail') | Should Be 'True'
            }
        It 'AdminEmail Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.AdminEmail.Attributes.Mandatory | Should be 'False'
            }
        It 'AdminEmail Parameter is of String Type' {
            $Function.Parameters.AdminEmail.ParameterType.FullName | Should be 'System.String'
            }
        It 'AdminEmail Parameter is member of ParameterSets' {
            [String]$Function.Parameters.AdminEmail.ParameterSets.Keys | Should Be '__AllParameterSets'
            }
        It 'AdminEmail Parameter Position is defined correctly' {
            [String]$Function.Parameters.AdminEmail.Attributes.Position | Should be '2'
            }
        It 'Does AdminEmail Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.AdminEmail.Attributes.ValueFromPipeline | Should be 'True'
            }
        It 'Does AdminEmail Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.AdminEmail.Attributes.ValueFromPipelineByPropertyName | Should be 'True'
            }
        It 'Does AdminEmail Parameter use advanced parameter Validation? ' {
            $Function.Parameters.AdminEmail.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should Be 'False'
            $Function.Parameters.AdminEmail.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should Be 'False'
            $Function.Parameters.AdminEmail.Attributes.TypeID.Name -contains 'ValidateScript' | Should Be 'False'
            $Function.Parameters.AdminEmail.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should Be 'False'
            $Function.Parameters.AdminEmail.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should Be 'False'
            }
        It 'Has Parameter Help Text for AdminEmail '{
            $function.Definition.Contains('.PARAMETER AdminEmail') | Should Be 'True'
            }
        It 'Has a Parameter called Connection' {
            $Function.Parameters.Keys.Contains('Connection') | Should Be 'True'
            }
        It 'Connection Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.Connection.Attributes.Mandatory | Should be 'False'
            }
        It 'Connection Parameter is of Hashtable Type' {
            $Function.Parameters.Connection.ParameterType.FullName | Should be 'System.Collections.Hashtable'
            }
        It 'Connection Parameter is member of ParameterSets' {
            [String]$Function.Parameters.Connection.ParameterSets.Keys | Should Be '__AllParameterSets'
            }
        It 'Connection Parameter Position is defined correctly' {
            [String]$Function.Parameters.Connection.Attributes.Position | Should be '3'
            }
        It 'Does Connection Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.Connection.Attributes.ValueFromPipeline | Should be 'True'
            }
        It 'Does Connection Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.Connection.Attributes.ValueFromPipelineByPropertyName | Should be 'True'
            }
        It 'Does Connection Parameter use advanced parameter Validation? ' {
            $Function.Parameters.Connection.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should Be 'False'
            $Function.Parameters.Connection.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should Be 'False'
            $Function.Parameters.Connection.Attributes.TypeID.Name -contains 'ValidateScript' | Should Be 'False'
            $Function.Parameters.Connection.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should Be 'False'
            $Function.Parameters.Connection.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should Be 'False'
            }
        It 'Has Parameter Help Text for Connection '{
            $function.Definition.Contains('.PARAMETER Connection') | Should Be 'True'
            }
    }
    Context "Function $($function.Name) - Help Section" {

            It "Function $($function.Name) Has show-help comment block" {

                $function.Definition.Contains('<#') | should be 'True'
                $function.Definition.Contains('#>') | should be 'True'
            }

            It "Function $($function.Name) Has show-help comment block has a.SYNOPSIS" {

                $function.Definition.Contains('.SYNOPSIS') -or $function.Definition.Contains('.Synopsis') | should be 'True'

            }

            It "Function $($function.Name) Has show-help comment block has an example" {

                $function.Definition.Contains('.EXAMPLE') | should be 'True'
            }

            It "Function $($function.Name) Is an advanced function" {

                $function.CmdletBinding | should be 'True'
                $function.Definition.Contains('param') -or  $function.Definition.Contains('Param') | should be 'True'
            }

    }

 }
