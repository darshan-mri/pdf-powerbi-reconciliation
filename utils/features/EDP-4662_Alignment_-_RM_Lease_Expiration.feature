Feature: Residential Lease Expiration - Table Visual Alignment in Power BI

  Scenario: User views the table visual with proper alignment
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to a page with a table visual
    Then The column names in the table should be left-aligned
    And The values in the table should be right-aligned