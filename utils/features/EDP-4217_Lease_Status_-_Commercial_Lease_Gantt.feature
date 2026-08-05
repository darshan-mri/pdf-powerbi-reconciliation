Feature: Commercial Lease Gantt

  Scenario: Display records based on Lease Status selection in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then a section titled "Lease Status" with categories should be clickable:
      | Current  |
      | Expired  |
      | MTM      |
      | Reserved |
    When the user selects any/all categories of the Lease Statuses
    Then the records in all the visuals should be displayed based on the selection(s) made