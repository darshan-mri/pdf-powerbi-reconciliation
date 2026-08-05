Feature: Residential AR Insights

  Scenario: User views Open Receivables and interacts with the table
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on "Open Receivables"
    Then The table headers along with proper data should be loaded
    And The total values of each age (Days) should match with the open charges keycards based on the selection
    When User selects any of the records from the table
    Then Relevant data should be displayed in key cards and other visuals