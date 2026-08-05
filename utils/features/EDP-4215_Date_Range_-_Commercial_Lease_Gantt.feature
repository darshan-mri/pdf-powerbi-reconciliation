Feature: Commercial Lease Gantt

  Scenario: Limit records based on date range in Power BI
    Given the user opens the report
    And the user selects the workspace
    When the user opens the report
    Then a section titled "Date Range" should be displayed where the lower and upper date range limits are editable
    When the user inputs the lower and upper limits
    Then the records in all the visuals should be limited based on the range entered
    | Lease Period  |
    | Lease Details |