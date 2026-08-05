Feature: Residential Lease Execution - Filter Functionality

  Scenario: User logs into Power BI and interacts with the report filters
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Filter show/hide pane
    Then The following filters should be displayed:
      | Date                |
      | Portfolio           |
      | Entity Type         |
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
      | Rent Code Flag      |
      | Building ID - Name  |
      | Property ID - Name  |
      | Project ID - Name   |
      | IsActiveProperty    |
      | Agent               |

    And The following filters should have default selections:
      | Date                | Current Date     |
      | IsActiveProperty    | true             |

    And The filter options should update dynamically based on the selections made
    And The visuals should display relevant data based on the selected filter conditions