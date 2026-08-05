Feature: Killian Commercial AR Insights
Scenario: User opens the report and verifies the Keycards
  Given User logs into PowerBI
  And User Selects the workspace
  When user Opens the Killian Report
  Then User should see the <Keycards> with MoreDetails Link
  When User clicks on MoreDetails link from <Keycards>
  Then Corresponding <Keycards> table should be displayed
  
 
    | Keycards |
    | Total Open Charges |
    | Total Billings |
    | Total Credits |
    | 1st Month |
    | 2nd Month |
    | 3rd Month |
    | 4+ Months |