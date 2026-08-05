Feature: Residential Lease Expiration - Focus Mode Interaction with Decomposition Tree

  Scenario: User interacts with the Decomposition of Expiring Rent tree in Focus Mode
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Focus Mode button/icon from the Decomposition of Expiring Rent tree
    Then The visual should expand to fill the screen
    And The user should see the "Back to report" button
    When The user clicks on the "Back to report" button
    Then It should navigate back to the page