Feature: B&F Financial NOI Analysis

  Scenario: Verify NOI MTD keycard display
    Given the user logs into Power BI
    When the user opens the Financial NOI Analysis report from the workspace
    Then the user should see the NOI MTD keycard with NOI amount, budget, NOI variance, and variance percentage displayed