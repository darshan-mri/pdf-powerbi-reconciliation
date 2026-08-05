Background:
  Given the user is logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/onboard-config" with clientID "P123456"

Scenario: Verify Onboarding Configuration header updates correctly after selecting client from Admin Settings
  When the user clicks on the "Admin Settings" menu option
  And the user clicks on "Client Onboard Configuration"
  Then the "Onboarding Configuration" page should be displayed
  And the header should display the client information as "P123456 - Internal - global playground"
  And the subheader should display "Onboarding Configuration"
  And the "Domain Name" field should contain "@mrisoftware.com"