Feature: Filter Pane Interaction in Power BI Report

  Scenario: User interacts with the filter pane in Power BI report
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Benderson Commercial Stacking Plan" report
    And the user clicks on the "Filter show/hide" pane
    Then the following filter options should be displayed:
      | Date                  |
      | Group by Hierarchy    |
      | Group by              |
      | Group by (Level 2)    |
      | Suite Sq. Ft          |
      | Entity Type           |
      | Life Code             |
      | Property Type         |
      | Property Sub Type     |
      | Class ID              |
      | Investment Flag       |
      | Investment Type       |
      | Location ID           |
      | State ID              |
      | Client Name           |
      | Company Group         |
      | Suite Type            |
      | Owner                 |
      | Asset Manager         |
      | Department            |
      | Manager               |
      | Landlord              |
      | Master Occupant       |
      | Store Category        |
      | Tenant Type Category  |
      | Tenant Type           |
      | National Tenant ID    |
      | SIC Code              |
      | Sq. Ft. Type          |
      | NAICSID1              |
      | NAICSID2              |
      | NAICSID3              |
      | NAICSID4              |
      | Cost Center           |
      | Cost Center Owner     |
      | District_D            |
      | District_H            |
      | DevelopmentGroup_D    |
      | DevelopmentGroup_H    |
      | Entity Type Id        |
      | Use Id                |
      | Dev Type Id           |
      | Seg Code Id           |
      | Building ID - Name    |
      | Portfolio ID - Name   |
      | Project ID - Name     |
      | IsActiveBuilding      |

    And the following filter options should have default selections:
      | Date                  | current Date      |
      | Group by Hierarchy    | Client Hierarchy  |
      | Group by              | Entity Type       |
      | Group by (Level 2)    | City              |
      | Suite Sq. Ft          | greater than 0    |
      | IsActiveBuilding      | true              |

    And the filter options should update dynamically based on the selections made
    And the visuals should update to display relevant data based on the selected filter conditions