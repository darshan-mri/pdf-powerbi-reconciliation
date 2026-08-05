Feature: Residential AR Pattern Report

  Scenario: User applies filters to the report and visuals update accordingly
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the Filter show/hide pane
    Then the following filters should be displayed:
      | Date                |
      | Portfolio           |
      | Entity Type         |
      | Source Code         |
      | Life Code           |
      | Property Type       |
      | Property Sub Type   |
      | Class ID            |
      | Investment Flag     |
      | Investment Type     |
      | Location ID         |
      | State ID            |
      | Unit Type           |
      | Owner               |
      | Asset Manager       |
      | Department          |
      | Unit                |
      | Resident Name       |
      | Regional Manager    |
      | Property Manager    |
      | Charge Code         |
      | Building ID - Name  |
      | Property ID - Name  |
      | IsActiveProperty    |
      | Agent               |

    And the following filters should have default selections:
      | Date                | current Date    |
      | IsActiveProperty    | true            |

    When the user selects filter options
    Then the filter options should update dynamically based on the selections made
    And the visuals in the report should display data based on the selected filter combinations