Feature: Residential AR Pattern Report

  Scenario: User views and interacts with the Billing and Payment Graph in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Residential AR Pattern" report
    Then the user should be able to see the Billing and Payment graph visual
    And the graph should have the X-axis representing the period and the Y-axis representing the aged billing and aged credit values
    When the user hovers over any bar in the graph
    Then the user should see the following tooltips:
      | Month - Year                  |
      | Billings/Credits              |
      | % Paid                        |
      | Prior month Charge %          |
      | Prior month Payment           |
    When the user selects a specific period bar in the graph
    Then all the visual values should be updated to reflect data for the selected period
    When the user deselects the selected period
    Then the visuals should revert back to show data for all periods