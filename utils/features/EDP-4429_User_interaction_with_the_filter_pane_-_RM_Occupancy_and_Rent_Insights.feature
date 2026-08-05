Feature: Residentials Occupancy and Rent Insights

  Scenario: Using the Filter show/hide pane and applying filter conditions
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on the Filter show/hide pane
    Then The following filter options should be displayed:
      | Date                |
      | Group by            |
      | Portfolio           |
      | EntityType          |
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
      | Property Manager    |
      | Bed and Bath        |
      | Building ID - Name  |
      | Property ID - Name  |
      | Project ID - Name   |
      | IsActiveProperty    |
      | Agent               |

    And The following <filter> options should have default selections:
      | Date               | Current Date      |
      | Group By           | is Building ID - Name |
      | IsActiveProperty   | true              |

    And The <filter> options should update dynamically based on the selections made
    And The visuals should display relevant data based on the selected filter conditions