Feature: Commercial Rent Roll

  Scenario: User views table visual with specific alignments
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And navigates to a page with a table visual
    Then the column names in the table should be left-aligned
    And the values in the table should be right-aligned