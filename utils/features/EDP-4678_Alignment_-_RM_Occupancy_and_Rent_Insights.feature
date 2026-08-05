Feature: Residentials Occupancy and Rent Insights

  Scenario: Viewing a report with proper table alignment
    Given User logs into Power BI
    And User selects the "Residentials Occupancy and Rent Insights" workspace
    When User opens the report
    And User navigates to a page with a table visual
    Then The column names in the table should be left-aligned
    And The values in the table should be right-aligned