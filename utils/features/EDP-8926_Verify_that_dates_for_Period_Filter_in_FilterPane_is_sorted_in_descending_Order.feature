Feature: Filters - Killian
Scenario Outline:Verify that Period Filter in FilterPane is sorted in descending Order
  Given User logs into Power BI
  And User Selects the workspace
  When User Opens the report
  And Click on the Filter show/hide pane
  Then Period Filter should be displayed in Available Filter Options
  And Click on Period Filter
  Then the Values for Period should be displayed in Descending order