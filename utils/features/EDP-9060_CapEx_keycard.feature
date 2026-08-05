Feature: B&F Financial Portfolio Hub

  Scenario: Verify CapEx keycard and related visuals
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    Then the user should see the CapEx keycard with the following details:
      | CapEx Amount     |
      | Budget           |
      | Variance         |
      | Variance %       |
    When the user clicks on the CapEx keycard
    Then the user should see the following visuals:
      | CapEx (Actual VS A. Stanton) line stacked column combo chart |
      | CapEx (Actual VS A. Stanton) table                           |
      | CapEx Variance scatter chart                                 |