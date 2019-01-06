InModuleScope SpanningO365{
  Describe 'Clear-SpanningAuthentication Functional Tests' {
    Context 'Testing validation for Clear-SpanningAuthentication'{
      $api = "addc5b8c-1565-4454-aec5-5878544f0727"
      $admin = "MeganB@M365x186877.OnMicrosoft.com"
      $region = "US"
      $auth = Get-SpanningAuthentication -ApiToken $api -Region $region -AdminEmail $admin

      It "Get-SpanningAuthentication populates script variables" {
        $auth | Should -not -Be $null
      }

      It "Get-SpanningAuthentication populates Session variables" {
        $Script:AuthInfo | Should -not -Be $null
      }

      It "Clear-SpanningAuthentication removes variables" {
        Clear-SpanningAuthentication
        $Script:AuthInfo | Should -Be $null
      }

    }
  }
}