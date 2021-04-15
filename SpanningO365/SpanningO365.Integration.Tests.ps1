<#	
.NOTES
===========================================================================
 Created with: 	VSCode and PowerShell
 Created on:   	3/12/2021
 Author:    	Matthew McDermott
 Organization: 	Spanning Cloud Apps
 Filename:     	SpanningO365.Integration.Tests.ps1
===========================================================================
.DESCRIPTION
A Pester integration test file for the SpanningO365 module. This file uses
the local file system and runs the functions in the module together to verify
that they run correctly.

#Pester 3 & 4 Syntax
$params = @{ApiToken = 'whosagoo-ddog-ruby-isagoodgirlright!'; Region = 'US'; AdminEmail = 'ruby@sharepointdog.com'}
$test = @{Path =  '.\SpanningO365.Integration.Tests.ps1'; Parameters = $params}
Invoke-Pester -Script $test

#Pester 5.1 Syntax
$params = @{ApiToken = 'whosagoo-ddog-ruby-isagoodgirlright!'; Region = 'US'; AdminEmail = 'ruby@sharepointdog.com'}
$container = New-PesterContainer -Path './SpanningO365.Integration.Tests.ps1' -Data $params
Invoke-Pester -Container $container -Output Detailed

#>

param (
    [Parameter(Mandatory)]
    [string] $ApiToken,
	[Parameter(Mandatory)]
    [string] $Region,
	[Parameter(Mandatory)]
    [string] $AdminEmail
)

	# Arrange functions go here

	# TODO - Add these tests.
    # Clear-SpanningAuthentication
    # Disable-SpanningUsersFromCSVAdvanced
    # Enable-SpanningUsersFromCSVAdvanced

# 

# This Describe block contains all integration tests for the Get-SpanningTenantInfo function
Describe "Get-SpanningTenantInfo Integration Test" -Tag "Integration" {
	
	# No mocking here. Context blocks are used for organization, not scope.
	Context "Get-SpanningTenantInfo" {
	
		It "Get-SpanningAuthentication - returns AuthInfo" {
			$auth = Get-SpanningAuthentication -ApiToken $ApiToken -Region $Region -AdminEmail $AdminEmail
			$auth | Should -Not -BeNullOrEmpty
		}

		It "Get-SpanningAuthentication - Authentication Header" {
			$auth = Get-SpanningAuthentication -ApiToken $ApiToken -Region $Region -AdminEmail $AdminEmail
			$($auth.Region) | Should -Be $Region
		}
		
		It "Get-SpanningTenantInfo - Users" {
			$(Get-SpanningTenantInfo).Users | Should -BeGreaterThan 0 
		}
		
		It "Get-SpanningTenantInfoPaymentStatus" {
			$(Get-SpanningTenantInfoPaymentStatus) | Should -BeIn @("trial","paid")
		}
	}
	
	Context "Get-SpanningUsers Functions" {
		
		It "Get-SpanningUsers" {
			$(Get-SpanningUsers).Count | Should -BeGreaterThan 0
		}
			
		It "Get-SpanningAdmins" {
			$(Get-SpanningAdmins).Count | Should -BeGreaterThan 0
		}
		
		It "Get-SpanningAssignedUsers" {
			$(Get-SpanningAssignedUsers).Count | Should -BeGreaterThan 0
		}

		It "Get-SpanningNonAdmins" {
			$(Get-SpanningNonAdmins).Count | Should -BeGreaterThan 0
		}

		It "Get-SpanningUnassignedUsers" {
			$(Get-SpanningUnassignedUsers).Count | Should -BeGreaterOrEqual 0
		}
	}
	
	Context "Get-SpanningUser" {
		
		It "Get-SpanningUser - by UPN" {
			$(Get-SpanningUser -UserPrincipalName $AdminEmail).email | Should -Be $AdminEmail
		}
		
		It "Get-SpanningUser - by Type Admins" {
			$(Get-SpanningUser -UserType Admins).Count | Should -BeGreaterThan 0
		}
		
		It "Get-SpanningUser - by Type NonAdmins" {
			$(Get-SpanningUser -UserType NonAdmins).Count | Should -BeGreaterThan 0
		}
		
		It "Get-SpanningUser - by Type Assigned" {
			$(Get-SpanningUser -UserType Assigned).Count | Should -BeGreaterThan 0
		}

		It "Get-SpanningUser - by Type Unassigned" {
			$(Get-SpanningUser -UserType Unassigned).Count | Should -BeGreaterOrEqual 0
		}
		It "Get-SpanningUser - by Type Deleted" {
			$(Get-SpanningUser -UserType Deleted).Count | Should -BeGreaterOrEqual 0
		}
		It "Get-SpanningUser - by Type NotDeleted" {
			$(Get-SpanningUser -UserType NotDeleted).Count | Should -BeGreaterThan 0
		}
		It "Get-SpanningUser - by Type All" {
			$(Get-SpanningUser -UserType All).Count | Should -BeGreaterThan 0
		}
	}

	Context "Enable-SpanningUser" {
		It "Enable-SpanningUser - by UPN" {
			$users = Get-SpanningUser -UserType Unassigned
			$(Enable-SpanningUser -UserPrincipalName $users[0].userPrincipalName).userPrincipalName | Should -Be $users[0].userPrincipalName
		}
	}

	Context "Disable-SpanningUser" {
		It "Disable-SpanningUser - by UPN" {
			$users = Get-SpanningUser -UserType Assigned
			$(Disable-SpanningUser -UserPrincipalName $users[0].userPrincipalName -Confirm:$false).userPrincipalName | Should -Be $users[0].userPrincipalName
		}
	}
}


