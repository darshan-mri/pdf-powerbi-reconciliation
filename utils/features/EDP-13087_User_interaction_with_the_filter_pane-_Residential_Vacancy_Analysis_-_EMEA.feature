Feature: Residential Vacancy Analysis

  Scenario: User interacts with the filter pane and visuals update accordingly

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the "Filter show/hide pane"
    Then the following filter options should be displayed:
      | Date               |
      | Portfolio          |
      | Project            |
      | Entity Type        |
      | Life Code          |
      | Property Type      |
      | Property Sub Type  |
      | Class ID           |
      | Investment Flag    |
      | Investment Type    |
      | Location ID        |
      | State ID           |
      | Unit Type          |
      | Owner              |
      | Asset Manager      |
      | Department         |
      | Property           |
      | Building Name      |
      | Unit ID            |
      | Tenant Name        |
      | Regional Manager   |
      | Property Manager   |
      | Agent              |
      
    And the filter options should update based on the changes made
    And the other visuals should display the relevant data based on the selected filter conditions
    And the following filter options should have default selections:
      | Date             | Current Date |

    And the filter options should update dynamically based on the selections made
    And the visuals should display relevant data based on the selected filter conditions