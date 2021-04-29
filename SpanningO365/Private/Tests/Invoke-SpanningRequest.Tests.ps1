Describe 'Invoke-SpanningRequest Tests' {

   Context 'Parameters for Invoke-SpanningRequest'{

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
        It 'Has a Parameter called RequestType' {
            $Function.Parameters.Keys.Contains('RequestType') | Should -Be 'True'
            }
        It 'RequestType Parameter is Identified as Mandatory being True' {
            [String]$Function.Parameters.RequestType.Attributes.Mandatory | Should -Be 'True'
            }
        It 'RequestType Parameter is of String Type' {
            $Function.Parameters.RequestType.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'RequestType Parameter is member of ParameterSets' {
            [String]$Function.Parameters.RequestType.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'RequestType Parameter Position is defined correctly' {
            [String]$Function.Parameters.RequestType.Attributes.Position | Should -Be '1'
            }
        It 'Does RequestType Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.RequestType.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does RequestType Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.RequestType.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does RequestType Parameter use advanced parameter Validation? ' {
            $Function.Parameters.RequestType.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.RequestType.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.RequestType.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.RequestType.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.RequestType.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for RequestType '{
            $function.Definition.Contains('.PARAMETER RequestType') | Should -Be 'True'
            }
        It 'Has a Parameter called UserPrincipalName' {
            $Function.Parameters.Keys.Contains('UserPrincipalName') | Should -Be 'True'
            }
        It 'UserPrincipalName Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.Mandatory | Should -Be 'False'
            }
        It 'UserPrincipalName Parameter is of String Type' {
            $Function.Parameters.UserPrincipalName.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'UserPrincipalName Parameter is member of ParameterSets' {
            [String]$Function.Parameters.UserPrincipalName.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'UserPrincipalName Parameter Position is defined correctly' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.Position | Should -Be '2'
            }
        It 'Does UserPrincipalName Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does UserPrincipalName Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.UserPrincipalName.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does UserPrincipalName Parameter use advanced parameter Validation? ' {
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.UserPrincipalName.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for UserPrincipalName '{
            $function.Definition.Contains('.PARAMETER UserPrincipalName') | Should -Be 'True'
            }
        It 'Has a Parameter called RequestAction' {
            $Function.Parameters.Keys.Contains('RequestAction') | Should -Be 'True'
            }
        It 'RequestAction Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.RequestAction.Attributes.Mandatory | Should -Be 'False'
            }
        It 'RequestAction Parameter is of String Type' {
            $Function.Parameters.RequestAction.ParameterType.FullName | Should -Be 'System.String'
            }
        It 'RequestAction Parameter is member of ParameterSets' {
            [String]$Function.Parameters.RequestAction.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'RequestAction Parameter Position is defined correctly' {
            [String]$Function.Parameters.RequestAction.Attributes.Position | Should -Be '3'
            }
        It 'Does RequestAction Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.RequestAction.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does RequestAction Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.RequestAction.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does RequestAction Parameter use advanced parameter Validation? ' {
            $Function.Parameters.RequestAction.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.RequestAction.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.RequestAction.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.RequestAction.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.RequestAction.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for RequestAction '{
            $function.Definition.Contains('.PARAMETER RequestAction') | Should -Be 'True'
            }
        It 'Has a Parameter called Size' {
            $Function.Parameters.Keys.Contains('Size') | Should -Be 'True'
            }
        It 'Size Parameter is Identified as Mandatory being False' {
            [String]$Function.Parameters.Size.Attributes.Mandatory | Should -Be 'False'
            }
        It 'Size Parameter is of Int Type' {
            $Function.Parameters.Size.ParameterType.FullName | Should -Be 'System.Int32'
            }
        It 'Size Parameter is member of ParameterSets' {
            [String]$Function.Parameters.Size.ParameterSets.Keys | Should -Be '__AllParameterSets'
            }
        It 'Size Parameter Position is defined correctly' {
            [String]$Function.Parameters.Size.Attributes.Position | Should -Be '4'
            }
        It 'Does Size Parameter Accept Pipeline Input?' {
            [String]$Function.Parameters.Size.Attributes.ValueFromPipeline | Should -Be 'True'
            }
        It 'Does Size Parameter Accept Pipeline Input by PropertyName?' {
            [String]$Function.Parameters.Size.Attributes.ValueFromPipelineByPropertyName | Should -Be 'True'
            }
        It 'Does Size Parameter use advanced parameter Validation? ' {
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateNotNullOrEmptyAttribute' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateNotNullAttribute' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateScript' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidateRangeAttribute' | Should -Be 'False'
            $Function.Parameters.Size.Attributes.TypeID.Name -contains 'ValidatePatternAttribute' | Should -Be 'False'
            }
        It 'Has Parameter Help Text for Size '{
            $function.Definition.Contains('.PARAMETER Size') | Should -Be 'True'
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


