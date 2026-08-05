Feature: B&F Financial Portfolio Hub

  Scenario: Verify NOI keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the NOI keycard with the following details:
      | NOI Amount   |
      | Budget       |
      | Variance     |
      | Variance %   |
    When the user clicks on the NOI keycard
    Then the user should see the following visuals:
      | NOI (Actual VS A. Stanton) line stacked column combo chart |
      | NOI (Actual VS A. Stanton) table                           |
      | NOI Variance scatter chart                                 |