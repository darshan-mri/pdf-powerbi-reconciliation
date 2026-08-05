Feature: Residential AR Insights

  Scenario: User views keycards without blank values
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The keycards should not have "Blank" as values