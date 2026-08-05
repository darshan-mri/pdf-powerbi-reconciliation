Feature: B&F Financial NOI Analysis

  Scenario: Verify Operating Expenses keycard display
    Given the user logs into Power BI
    When the user opens the Financial NOI Analysis report from the workspace
    Then the user should see the Operating Expenses keycard with operating expenses amount, budget, operating expenses variance, and variance percentage displayed