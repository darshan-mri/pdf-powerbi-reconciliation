Feature: Residential AR Insights

  Scenario: Verifying More Details functionality in key cards
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the user should see the keycard with the more details option
    When user clicks on More Details from the key cards
    Then the details table for the corresponding key cards should be displayed