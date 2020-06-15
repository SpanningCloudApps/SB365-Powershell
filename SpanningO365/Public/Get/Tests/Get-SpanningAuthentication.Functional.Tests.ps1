Describe 'Get-SpanningAuthentication Functional Tests' {
  Context 'Testing response validation for Get-SpanningAuthentication'{
    $api = "addc5b8c-1565-4454-aec5-5878544f0727"
    $admin = "MeganB@M365x186877.OnMicrosoft.com"
    $region = "US"

    $azConnection = @{
      AdminEmail = $admin
      ApiToken = $api
      Region = $region
  }

    It "Get-SpanningAuthentication returns valid region" {
      (Get-SpanningAuthentication -ApiToken $api -Region $region -AdminEmail $admin).Region | Should be $region
    }

    It "Get-SpanningAuthentication returns 1 Header" {
      (Get-SpanningAuthentication -ApiToken $api -Region $region -AdminEmail $admin).Headers.Count | Should be 1
    }

    Clear-SpanningAuthentication

    It "Get-SpanningAuthentication with Connection returns valid region" {
      (Get-SpanningAuthentication -Connection $azConnection).Region | Should be $region
    }

    It "Get-SpanningAuthentication with Connection returns 1 Header" {
      (Get-SpanningAuthentication -Connection $azConnection).Headers.Count | Should be 1
    }
    It "Get-SpanningAuthentication fails with malformed token" {
      {Get-SpanningAuthentication -ApiToken "addc5b8c-1565-4454-aec5-5878544f07" -Region $region -AdminEmail $admin} | Should throw
    }
  }
}