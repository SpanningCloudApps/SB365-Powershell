Describe 'Enable-SpanningUsersFromCSVAdvanced Tests' {

   Context 'Parameters for Enable-SpanningUsersFromCSVAdvanced'{

        It 'Has a Parameter called AuthInfo' {
            $Function.Parameters.Keys.Contains('AuthInfo') | Should -Be 'True'
            }
        It 'AuthInfo Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.AuthInfo.Attributes.Mandatory | Should -Be 'False'
            }
        It 'AuthInfo Parameter is of Object Type' {
            $Function.Parameters.AuthInfo.ParameterType.FullName | Should -Be 'System.Object'
            }
        It 'AuthInfo Parameter is member of ParameterSets' {
            [String]$Function.Parameters.AuthInfo.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'AuthInfo Parameter Position is defined correctly' {
            [String]$Function.Parameters.AuthInfo.Attributes.Position | Should -Be '0'
            }
        It 'Does AuthInfo Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.AuthInfo.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does AuthInfo Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.AuthInfo.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does AuthInfo Parameter use advanced parameter Validation? ' {
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.AuthInfo.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for AuthInfo '{
            $function.Definition.Contains('.PARAMETER AuthInfo') | Should -Be 'True'
            }
        It 'Has a Parameter called Path' {
            $Function.Parameters.Keys.Contains('Path') | Should -Be 'True'
            }
        It 'Path Parameter is Identified as Mandatory being True' {
            [String]$Function.Parameters.Path.Attributes.Mandatory | Should -Be 'True'
            }
        It 'Path Parameter is of String Type' {
            $Function.Parameters.Path.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'Path Parameter is member of ParameterSets' {
            [String]$Function.Parameters.Path.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'Path Parameter Position is defined correctly' {
            [String]$Function.Parameters.Path.Attributes.Position | Should -Be '-2147483648'
            }
        It 'Does Path Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.Path.Attributes.ValueFromPipeline | Should -Be 'False'
            }
        It 'Does Path Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.Path.Attributes.ValueFromPipelineByPropertyName | Should -Be 'False'
            }
        It 'Does Path Parameter use advanced parameter Validation? ' {
            $Function.Parameters.Path.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'True'
            $Function.Parameters.Path.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.Path.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.Path.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.Path.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for Path '{
            $function.Definition.Contains('.PARAMETER Path') | Should -Be 'True'
            }
        It 'Has a Parameter called UpnColumn' {
            $Function.Parameters.Keys.Contains('UpnColumn') | Should -Be 'True'
            }
        It 'UpnColumn Parameter is Identified as Mandatory being True' {
            [String]$Function.Parameters.UpnColumn.Attributes.Mandatory | Should -Be 'True'
            }
        It 'UpnColumn Parameter is of Int32 Type' {
            $Function.Parameters.UpnColumn.ParameterType.FullName | Should -Be 'System.Int32'
            }
        It 'UpnColumn Parameter is member of ParameterSets' {
            [String]$Function.Parameters.UpnColumn.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'UpnColumn Parameter Position is defined correctly' {
            [String]$Function.Parameters.UpnColumn.Attributes.Position | Should -Be '-2147483648'
            }
        It 'Does UpnColumn Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.UpnColumn.Attributes.ValueFromPipeline | Should -Be 'False'
            }
        It 'Does UpnColumn Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.UpnColumn.Attributes.ValueFromPipelineByPropertyName | Should -Be 'False'
            }
        It 'Does UpnColumn Parameter use advanced parameter Validation? ' {
            $Function.Parameters.UpnColumn.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'True'
            $Function.Parameters.UpnColumn.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.UpnColumn.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.UpnColumn.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.UpnColumn.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for UpnColumn '{
            $function.Definition.Contains('.PARAMETER UpnColumn') | Should -Be 'True'
            }
        It 'Has a Parameter called FilterColumn' {
            $Function.Parameters.Keys.Contains('FilterColumn') | Should -Be 'True'
            }
        It 'FilterColumn Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.FilterColumn.Attributes.Mandatory | Should -Be 'False'
            }
        It 'FilterColumn Parameter is of Int32 Type' {
            $Function.Parameters.FilterColumn.ParameterType.FullName | Should -Be 'System.Int32'
            }
        It 'FilterColumn Parameter is member of ParameterSets' {
            [String]$Function.Parameters.FilterColumn.ParameterSets.Keys | Should -Be 'Filter'
            }
        It 'FilterColumn Parameter Position is defined correctly' {
            [String]$Function.Parameters.FilterColumn.Attributes.Position | Should -Be '-2147483648'
            }
        It 'Does FilterColumn Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.FilterColumn.Attributes.ValueFromPipeline | Should -Be 'False'
            }
        It 'Does FilterColumn Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.FilterColumn.Attributes.ValueFromPipelineByPropertyName | Should -Be 'False'
            }
        It 'Does FilterColumn Parameter use advanced parameter Validation? ' {
            $Function.Parameters.FilterColumn.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.FilterColumn.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.FilterColumn.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.FilterColumn.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.FilterColumn.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for FilterColumn '{
            $function.Definition.Contains('.PARAMETER FilterColumn') | Should -Be 'True'
            }
        It 'Has a Parameter called FilterColumnValue' {
            $Function.Parameters.Keys.Contains('FilterColumnValue') | Should -Be 'True'
            }
        It 'FilterColumnValue Parameter is Identified as Mandatory being True' {
            [String]$Function.Parameters.FilterColumnValue.Attributes.Mandatory | Should -Be 'True'
            }
        It 'FilterColumnValue Parameter is of String Type' {
            $Function.Parameters.FilterColumnValue.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'FilterColumnValue Parameter is member of ParameterSets' {
            [String]$Function.Parameters.FilterColumnValue.ParameterSets.Keys | Should -Be 'Filter'
            }
        It 'FilterColumnValue Parameter Position is defined correctly' {
            [String]$Function.Parameters.FilterColumnValue.Attributes.Position | Should -Be '-2147483648'
            }
        It 'Does FilterColumnValue Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.FilterColumnValue.Attributes.ValueFromPipeline | Should -Be 'False'
            }
        It 'Does FilterColumnValue Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.FilterColumnValue.Attributes.ValueFromPipelineByPropertyName | Should -Be 'False'
            }
        It 'Does FilterColumnValue Parameter use advanced parameter Validation? ' {
            $Function.Parameters.FilterColumnValue.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'True'
            $Function.Parameters.FilterColumnValue.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.FilterColumnValue.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.FilterColumnValue.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.FilterColumnValue.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for FilterColumnValue '{
            $function.Definition.Contains('.PARAMETER FilterColumnValue') | Should -Be 'True'
            }
    }
    Context "Function $($function.Name) - Help Section" {

            It "Function $($function.Name) Has show-help comment block" {

                $function.Definition.Contains('<#') | Should -Be 'True'
                $function.Definition.Contains('#>') | Should -Be 'True'
            }

            It "Function $($function.Name) Has show-help comment block has a.SYNOPSIS" {

                $function.Definition.Contains('.SYNOPSIS') -or $function.Definition.Contains('.Synopsis') | Should -Be 'True'

            }

            It "Function $($function.Name) Has show-help comment block has an example" {

                $function.Definition.Contains('.EXAMPLE') | Should -Be 'True'
            }

            It "Function $($function.Name) Is an advanced function" {

                $function.CmdletBinding | Should -Be 'True'
                $function.Definition.Contains('param') -or  $function.Definition.Contains('Param') | Should -Be 'True'
            }
    }
 }


