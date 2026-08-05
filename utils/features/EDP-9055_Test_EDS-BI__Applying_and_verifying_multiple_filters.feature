Feature: B&F Financial NOI Analysis

  Scenario Outline: Verify that report visuals update based on applied filters
    Given the user logs into Power BI
    And the user opens the Financial NOI Analysis report from the workspace
    When the user applies the "<Filter>" from the filter pane
    Then the visuals in the report should update and display values based on the selected filter

    Examples:
      | Filter             |
      | Period             |
      | Group By           |
      | Group By (Level 2) |
      | Timeframe          |
      | Is Active          |
      | Variance Type      |
      | Budget             |
      | Workbook           |
      | Scenario           |