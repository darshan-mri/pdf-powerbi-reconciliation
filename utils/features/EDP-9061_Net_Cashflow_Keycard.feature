Feature: B&F Financial Portfolio Hub

  Scenario: Verify Net Cashflow keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the Net Cashflow keycard with the following details:
      | Net Cashflow Amount   |
      | Budget                |
      | Variance              |
      | Variance %            |
    When the user clicks on the Net Cashflow keycard
    Then the user should see the following visuals:
      | Net Cashflow (Actual VS A. Stanton) line stacked column combo chart |
      | Net Cashflow (Actual VS A. Stanton) table                           |
      | Net Cashflow Variance scatter chart                                 |