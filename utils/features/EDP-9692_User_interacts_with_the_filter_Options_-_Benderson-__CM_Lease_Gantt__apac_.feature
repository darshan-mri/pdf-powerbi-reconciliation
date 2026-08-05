Feature:Filters - Benderson CM Lease Expiration
Scenario: User interacts with the filter pane in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the "Filter show/hide" pane
    Then the following filter options should be displayed:
      | Filters              |
      | Date                 |
      | Suite sq.ft          |
      | Project ID - Name    |
      | Building ID - Name   |
      | Portfolio ID - Name  |
      | Entity Type          |
      | Basis                |
      | Portfolio            |
      | Life code            |
      | Property type        |
      | Property sub type    |
      | Class ID             |
      | Investment flag      |
      | Investment type      |
      | Location ID          |
      | State ID             |
      | Suite Type           |
      | Client Name          |
      | Company Group        |
      | Owner                |
      | Asset manager        |
      | Department           |
      | Manager              |
      | Landlord             |
      | Master occupant      |
      | Store category       |
      | Tenant Type          |
      | Tenant Type Category |
      | National Tenant ID   |
      | SIC Code             |
      | Unit measurement ID  |
      | NAICSID1             |
      | NAICSID2             |
      | NAICSID3             |
      | NAICSID4             |
      | Cost Center          |
      | Cost center Owner    |
      | Entity Type ID       |
      | District_D           |
      | District_H           |
      | Developmentgroup_D   |
      | Developmentgroup_H   |
      | IsActiveBuilding     |
      | EntityTypeID         |
      | USE ID               |
      | Dev Type ID          |
      | Seg Code ID          |

    And the following filter options should have default selections:
      | Filter              | Default Value                |
      | Date                | Current Date / Refreshed date|
      | Suite sq.ft         | Grater than 0                |
      | EntityTypeID        | F, MH, P, R, or T            |
      | IsActiveBuilding    | true                         |

    And the filter options should update dynamically based on the selections made
    And the visuals should display relevant data based on the selected filter condition