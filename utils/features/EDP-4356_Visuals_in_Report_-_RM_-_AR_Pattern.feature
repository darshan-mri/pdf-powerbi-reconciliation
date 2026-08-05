Feature: Residential AR Pattern

  Scenario: Verifying that the report loads without breaking any visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the report should load without breaking any visuals