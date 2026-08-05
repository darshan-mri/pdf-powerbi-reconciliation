Feature: Residential Occupancy - Dynamic Filter and Data Update

  Scenario: User interacts with the Filter show/hide pane and updates filter conditions
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Filter show/hide pane
    Then the following filter options should be displayed and the filter options should update based on the changes made
    And the other visuals should display the relevant data based on the filter condition selected
    | Filters               |
    | Date                  |
    | Group By              |
    | Portfolio             |
    | Entity Type           |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Class ID              |
    | Investment Flag       |
    | Investment Type       |
    | Location ID           |
    | State ID              |
    | Unit Type             |
    | Owner                 |
    | Asset Manager         |
    | Department            |
    | Unit ID               |
    | Resident Name         |
    | Manager               |
    | Regional Manager      |
    | Bed and Bath          |
    | Building ID - Name    |
    | Property ID - Name    |
    | Project ID - Name     |
    | IsActiveProperty      |
    | Agent                 |

    And the following filter options should have default selections
    | Date                  | Current Date      |
    | Group By              | Is Building ID - Name |
    | IsActiveProperty      | true              |

    And the filter options should update dynamically based on the selections made
    And the visuals should display relevant data based on the selected filter conditions