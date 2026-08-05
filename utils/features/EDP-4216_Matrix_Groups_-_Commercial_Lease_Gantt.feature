Feature: Commercial Lease Gantt

  Scenario: Display records based on Matrix Groups selection in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then a section titled "Matrix Groups" with Group by fields should be clickable:
      | Matrix Groups       |
      | Portfolio ID - Name |
      | Project ID - Name   |
      | Building ID - Name  |
    When the user selects any of the Matrix Groups
    Then the records in all the visuals should be displayed based on the selection made