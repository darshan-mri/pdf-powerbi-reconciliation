Feature: B&F Financial Portfolio Hub

  Scenario: Verify Debt Service keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the Debt Service keycard with the following details:
      | Debt Service Amount   |
      | Budget                |
      | Variance              |
      | Variance %            |
    When the user clicks on the Debt Service keycard
    Then the user should see the following visuals:
      | Debt Service (Actual VS A. Stanton) line stacked column combo chart |
      | Debt Service (Actual VS A. Stanton) table                           |
      | Debt Service Variance scatter chart                                 |