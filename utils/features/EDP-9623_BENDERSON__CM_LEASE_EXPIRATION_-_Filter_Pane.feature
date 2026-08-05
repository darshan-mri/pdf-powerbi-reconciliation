Feature: Filter Pane Interaction in Benderson Commercial Lease Expiration Report

  Scenario: User interacts with the filter pane
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Benderson Commercial Lease Expiration" report
    And the user clicks on the "Filter show/hide" pane
    Then the following filter options should be displayed:
      | Date                |
      | Suite Sq. Ft        |
      | Entity Type         |
      | Life Code           |
      | Property Type       |
      | Property Sub Type   |
      | Project ID - Name   |
      | Class ID            |
      | Investment Flag     |
      | Investment Type     |
      | Location ID         |
      | State ID            |
      | Client Name         |
      | Company Group       |
      | Suite Type          |
      | Owner               |
      | Asset Manager       |
      | Department          |
      | Manager             |
      | Landlord            |
      | Master Occupant     |
      | Store Category      |
      | Tenant Type Category|
      | Tenant Type         |
      | National Tenant ID  |
      | SIC Code            |
      | Building ID - Name  |
      | Portfolio ID - Name |
      | Property Name       |
      | NAICSID1            |
      | NAICSID2            |
      | NAICSID3            |
      | NAICSID4            |
      | Cost Center         |
      | Cost Center Owner   |
      | District_D          |
      | District_H          |
      | DevelopmentGroup_D  |
      | DevelopmentGroup_H  |
      | Entity Type ID      |
      | Use ID              |
      | Dev Type ID         |
      | Seg Code ID         |
      | IsActiveBuilding    |
    And the following filter options should have default selections:
      | Date           | current Date   |
      | Suite Sq. Ft   | greater than 0 |
      | IsActiveBuilding | true         |
    And the filter options should update dynamically based on the selections made
    And the visuals should update to display relevant data based on the selected filter conditions