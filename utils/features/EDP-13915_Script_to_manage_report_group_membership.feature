Scenario: Execute report group setup script successfully
  Given I have valid Okta client credentials
  And I have a valid CSV file with group and user details
  And all required PowerShell scripts are unblocked
  And I am running the script using PowerShell 7
  When I execute the Invoke-ReportGroupsSetup script
  Then the CSV data validation should pass
  And the access token should be generated successfully
  And report access groups should be created or updated
  And users should be added to the corresponding groups
  And no execution or authorization errors should occur