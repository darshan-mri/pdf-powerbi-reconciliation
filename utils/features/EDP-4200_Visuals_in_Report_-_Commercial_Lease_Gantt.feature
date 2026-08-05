Feature: Commercial Lease Gantt - Visuals

  Scenario: Verify Financial NOI Analysis report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial Lease Gantt" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Date Range              |
      | Matrix groups           |
      | Lease Status            |
      | Lease Period            |
      | Lease Details Table     |
      | Lease Status Pie chart  |