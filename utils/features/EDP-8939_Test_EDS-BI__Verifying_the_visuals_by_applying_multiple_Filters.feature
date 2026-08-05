Feature: B&F Financial Details

Scenario Outline: User applies filters from the filter pane and sees the updated visuals
    Given The User logs into Power BI
    And The User opens the Financial Details report from the workspace
    When The User applies the <Filters> from the filter pane
    Then The visuals in the report are updated, and values are displayed according to the selected filter

    Examples:
      | Filters    |
      | Period     |
      | Group By   |
      | Budget     |
      | Scenario   |
      | Workbook   |