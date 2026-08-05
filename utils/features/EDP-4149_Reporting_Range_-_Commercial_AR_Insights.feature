Feature: Commercial AR Insights - Reporting Range
  Scenario: User views Reporting Range in Commercial AR Insights Report
    Given the user is logged into Power BI
    And the user has selected the "Commercial AR Insights" workspace
    When the user opens the "Commercial AR Insights Report"
    Then the Reporting Range selector should be visible
    And the following <Reporting Range> should be available:
      | Reporting Range    |
      | 30                 |
      | 60                 |
      | 90                 |
      | 120                |
      | Trailing 12 months |
    And the default selected Reporting Range should be "30"
    And based on the selection, data in the report should restrict for the following <Visuals>:
      | Visuals                         |
      | Open Receivables Trends Chart   |
      | Open Receivables Details table  |
      | Open Receivables Details Chart  |