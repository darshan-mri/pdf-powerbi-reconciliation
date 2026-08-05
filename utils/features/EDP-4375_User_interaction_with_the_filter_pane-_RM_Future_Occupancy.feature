Feature: Residential Future Occupancy

  Scenario: Displaying and Updating Filters with Relevant Visual Data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on the Filter show/hide pane
    Then The following filters should be displayed:
      | Filters               |
      | Date                  |
      | Portfolio             |
      | Entity type           |
      | Life code             |
      | Property type         |
      | Property sub type     |
      | Class id              |
      | Investment type       |
      | Investment flag       |
      | Location ID           |
      | State ID              |
      | Unit Type             |
      | Owner                 |
      | Asset manager         |
      | Department            |
      | Unit                  |
      | Resident name         |
      | Unit area             |
      | Property Name - ID    |
      | Building Name - ID    |
      | Regional Manager      |
      | Property Manager      |
      | Unit Area             |
      | Project ID - Name     |
      | isActiveProperty      |
      | Agent                 |
      
    And The following filter options should have default selections:
      | Date                  | Current Date      |
      | IsActiveProperty      | true              |
    And The filter options should update dynamically based on the selections made
    And The visuals should display relevant data based on the selected filter conditions