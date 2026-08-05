Feature: Commercial Lease Expiration

  Scenario: Apply and update filter options in the report
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And clicks on the Filter show/hide pane
    Then the following filter options should be displayed:
      | Date                |
      | Suite Sq. Ft        |
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
      | Client Name         |
      | Company Group       |
      | Suite Type          |
      | Owner               |
      | Asset Manager       |
      | Department Name     |
      | Manager             |
      | Landlord            |
      | Master Occupant     |
      | Store Category      |
      | Tenant Type Category|
      | Tenant Type         |
      | SIC Code            |
      | Building ID - Name  |
      | Property ID - Name  |
      | Project ID - Name   |
      | isActiveBuilding    |
      
    And by default the following filters should be selected
      | Filters           | Default Value   |
      | Date              | Current Date    |
      | Suite Sq. Ft      | greater than 0  |
      | isActiveBuilding  | true            |
    And the filter options should update based on the selections made
    And the other visuals should display the relevant data based on the selected filter conditions