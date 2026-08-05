Feature: Lightstone Financial NOI Analysis
Scenario: User verifies Keycard values in the report match the PDF
  Given User logs into Power BI
  And User selects the Workspace
  When User opens the report
  Then User should be able to see the Keycards
  And The Keycard values should be displayed exactly as in the PDF