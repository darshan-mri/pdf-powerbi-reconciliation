Feature: B&F Financial Portfolio Hub

  Scenario: Verify Non-OpEx keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the Non-OpEx keycard with the following details:
      | Non-OpEx Amount   |
      | Budget            |
      | Variance          |
      | Variance %        |
    When the user clicks on the Non-OpEx keycard
    Then the user should see the following visuals:
      | Non-OpEx (Actual VS A. Stanton) line stacked column combo chart |
      | Non-OpEx (Actual VS A. Stanton) table                           |
      | Non-OpEx Variance scatter chart                                 |