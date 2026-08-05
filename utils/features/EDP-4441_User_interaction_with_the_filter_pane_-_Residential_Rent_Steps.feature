Feature:Residential Rent step - Filter Functionality and Dynamic Data Display in Power BI Report

  Scenario: Verifying the Filter pane functionality and data updates in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Filter show/hide pane
    Then the following filter options should be displayed and the filter options should update based on the changes made and the other visuals should display the relevant data based on the filter condition selected
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
      | Unit ID             |
      | Resident Name       |
      | Regional Manager    |
      | Building ID - Name  |
      | Property ID - Name  |
      | Project ID - Name   |
      | IsActiveProperty    |
      | Agent               |

    And the following <filter> options should have default selections
      | Date               | Current Date      |
      | IsActiveProperty   | true              |

    And the <filter> options should update dynamically based on the selections made
    And the visuals should display relevant data based on the selected filter conditions