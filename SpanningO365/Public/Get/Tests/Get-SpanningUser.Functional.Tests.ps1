Describe 'Get-SpanningUser Functional Tests' {
  BeforeAll {
    $api = "addc5b8c-1565-4454-aec5-5878544f0727"
    $admin = "MeganB@M365x186877.OnMicrosoft.com"
    $region = "US"
    $auth = Get-SpanningAuthentication -ApiToken $api -Region $region -AdminEmail $admin
    $auth | Out-Null # ToDo - Hide ScriptAnalyzer Scope Error
  }
  Mock -CommandName Invoke-WebRequest -Verifiable -MockWith {
    #This mock creates a data set of two users for the first request. It returns a nextLink to validate the loop.
    $restResult = @{
      nextLink="https://o365-api-us.spanningbackup.com/external/users?msIdOffset=42317567-8833-4b6b-863f-07bb5d58e484&sortPropOffset=HumaydZ%40M365x186877.onmicrosoft.com&size=50"
      users=@()
    }
    #User Result
    $restResult.users += [PSCustomObject]@{
        userPrincipalName = "admin@M365x186877.onmicrosoft.com"
        msId              = "2206806c-7a66-4a1b-b3b1-7fa00909e9b1"
        assigned          = "True"
        isAdmin           = "True"
        isDeleted         = "False"
      }
    $restResult.users += [PSCustomObject]@{
        userPrincipalName = "IsaiahL@M365x186877.OnMicrosoft.com"
        msId              = "7fa78e20-1933-4aa6-ba63-50d48470242b"
        assigned          = "False"
        isAdmin           = "False"
        isDeleted         = "False"
      }
    return $restResult | ConvertTo-Json
  } `
  -ParameterFilter {
    $uri -like "https://o365-api-??.spanningbackup.com/external/users?size*"
  } -ModuleName SpanningO365

  #This mock creates two additional users for the second request and returns a blank next link to stop the loop
  Mock -CommandName Invoke-WebRequest -Verifiable -MockWith {
    $restResult = @{
      nextLink=""
      users=@()
    }
    #$restResult = @()
    $restResult.users += [PSCustomObject]@{
        userPrincipalName = "ruby@M365x186877.onmicrosoft.com"
        msId              = "4406806c-7a66-4a1b-b3b1-7fa00909e9b1"
        assigned          = "False"
        isAdmin           = "False"
        isDeleted         = "False"
      }
    $restResult.users += [PSCustomObject]@{
        userPrincipalName = "willa@M365x186877.OnMicrosoft.com"
        msId              = "77a78e20-1933-4aa6-ba63-50d48470242b"
        assigned          = "True"
        isAdmin           = "False"
        isDeleted         = "True"
      }
    return $restResult | ConvertTo-Json
  } `
  -ParameterFilter {
    $uri -like "https://o365-api-??.spanningbackup.com/external/users?msIdOffset*"
  } -ModuleName SpanningO365

  Context 'Testing validation for Get-SpanningUser'{

    It "Get-SpanningUser -UserType Admins has more than 0 Admins" {
      [array]$users = Get-SpanningUser -AuthInfo $auth -UserType Admins
      $users.Count | Should -Be 1
      # ToDo Assert-VerifiableMock to Should -InvokeVerifiable https://pester.dev/docs/commands/Should#invokeverifiable
      Assert-VerifiableMock
    }

    It "GetSpanningUser Returns an [array]" {
      $users = Get-SpanningUser -AuthInfo $auth -UserType All
      Write-Output $users -NoEnumerate | Should -BeOfType [array]
    }

    It "Alternate GetSpanningUser Returns an [array]" {
      $users = Get-SpanningUser -AuthInfo $auth -UserType All
      $users -is [array] | Should -Be $true
    }

    It "Get-SpanningUser -UserType Assigned has 2 Users" {
      $users = Get-SpanningUser -AuthInfo $auth -UserType Assigned
      $users.Count | Should -Be 2
      # ToDo Assert-VerifiableMock to Should -InvokeVerifiable https://pester.dev/docs/commands/Should#invokeverifiable
      Assert-VerifiableMock
    }

    It "Get-SpanningUser -UserType All has 4 Users" {
      $users = Get-SpanningUser -AuthInfo $auth -UserType All
      $users.Count | Should -Be 4
      # ToDo Assert-VerifiableMock to Should -InvokeVerifiable https://pester.dev/docs/commands/Should#invokeverifiable
      Assert-VerifiableMock
    }

    It "Get-SpanningUser -UserType Deleted has 1 User" {
      [array]$users = Get-SpanningUser -AuthInfo $auth -UserType Deleted
      $users.Count | Should -Be 1
      # ToDo Assert-VerifiableMock to Should -InvokeVerifiable https://pester.dev/docs/commands/Should#invokeverifiable
      Assert-VerifiableMock
    }

    It "Get-SpanningUser -UserType NotDeleted has 3 Users" {
      $users = Get-SpanningUser -AuthInfo $auth -UserType NotDeleted
      $users.Count | Should -Be 3
      # ToDo Assert-VerifiableMock to Should -InvokeVerifiable https://pester.dev/docs/commands/Should#invokeverifiable
      Assert-VerifiableMock
    }

    #Test Get-SpanningUser -Size 100 -Verbose -UserType Admins
    It "Get-SpanningUser -UserType Admins -Size 100 has 1 User" {
      [array]$users = Get-SpanningUser -AuthInfo $auth -UserType Admins -Size 100
      $users.Count | Should -Be 1
      # ToDo Assert-VerifiableMock to Should -InvokeVerifiable https://pester.dev/docs/commands/Should#invokeverifiable
      Assert-VerifiableMock
      #Did we call the loop twice? TODO : Mock the Size Parameter to evaluate the effectiveness at changing the Scope
      # ToDo Assert-MockCalled to Should -Invoke https://pester.dev/docs/commands/Should#invoke
      Assert-MockCalled -CommandName Invoke-WebRequest -Times 2 -Exactly -ModuleName SpanningO365 -Scope It
    }

    It "Get-SpanningUser -Size 100 has 4 Users" {
      [array]$users = Get-SpanningUser -AuthInfo $auth -Size 1
      $users.Count | Should -Be 4
      # Assert
      Assert-VerifiableMock
      #Did we call the loop twice? TODO : Mock the Size Parameter to evaluate the effectiveness at changing the Scope
      # ToDo Assert-MockCalled to Should -Invoke https://pester.dev/docs/commands/Should#invoke
      Assert-MockCalled -CommandName Invoke-WebRequest -Times 2 -Exactly -ModuleName SpanningO365 -Scope It
    }
  }
}
