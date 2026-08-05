Feature: B&F Financial Portfolio Hub

  Scenario: Verify Revenues keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the Revenues keycard with the following details:
      | Revenue Amount   |
      | Budget           |
      | Variance         |
      | Variance %       |
    When the user clicks on the Revenue keycard
    Then the user should see the following visuals:
      | Revenue (Actual VS A. Stanton) line stacked column combo chart |
      | Revenue (Actual VS A. Stanton) table                           |
      | Revenue Variance scatter chart                                 |