Feature: B&F Financial Portfolio Hub

  Scenario: Verify OpEx keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the OpEx keycard with the following details:
      | OpEx Amount   |
      | Budget        |
      | Variance      |
      | Variance %    |
    When the user clicks on the OpEx keycard
    Then the user should see the following visuals:
      | OpEx (Actual VS A. Stanton) line stacked column combo chart |
      | OpEx (Actual VS A. Stanton) table                           |
      | OpEx Variance scatter chart                                 |