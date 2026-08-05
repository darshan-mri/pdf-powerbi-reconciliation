Feature: Benderson CM Occupancy
Scenario: User logs into Power BI, views the report, and checks the alignment
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then User should be able to see all the visuals with proper alignment
    When the user navigates to the page with a table visual
    Then The column names in the table should be left-aligned
    And The values in the table should be right-aligned