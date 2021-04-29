Describe 'Clear-SpanningAuthentication Functional Tests' {
  BeforeAll {
    $api = "addc5b8c-1565-4454-aec5-5878544f0727"
    $admin = "MeganB@M365x186877.OnMicrosoft.com"
    $region = "US"
    $auth = Get-SpanningAuthentication -ApiToken $api -Region $region -AdminEmail $admin
    $auth | Out-Null # ToDo - Hide ScriptAnalyzer Scope Error
  }

  Context 'Testing validation for Clear-SpanningAuthentication'{

    It "Get-SpanningAuthentication populates script variables" {
      $auth | Should -not -Be $null
    }

    It "Get-SpanningAuthentication populates Session variables" {
      InModuleScope SpanningO365 {
        $Script:AuthInfo | Should -not -Be $null
      }
    }

    It "Clear-SpanningAuthentication removes variables" {
      InModuleScope SpanningO365 {
        Clear-SpanningAuthentication
        $Script:AuthInfo | Should -Be $null
      }
    }

  }
}
