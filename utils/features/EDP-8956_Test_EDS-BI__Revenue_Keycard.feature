Feature: B&F Financial NOI Analysis

  Scenario: Verify Revenue keycard display
    Given the user logs into Power BI
    When the user opens the Financial NOI Analysis report from the workspace
    Then the user should see the Revenue keycard with revenue amount, budget, revenue variance, and variance percentage displayed