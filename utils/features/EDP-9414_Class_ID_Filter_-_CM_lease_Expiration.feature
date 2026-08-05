Feature: Commercial Lease Expiration

  Scenario: Interact with "Lease expiration by month" visual in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should see the "Lease expiration by month" bar graph visual without any breakage
    And the user should see the following options on the visual:
      | Building ID - Name |
      | Regional Manager   |
      | Property Manager   |
      | Bed and Bath       |
      | Class ID           |
      | No grouping        |
      | Property ID - Name |
    When the user selects the Class ID option
    Then the visual should be updated according to the selected option
    When the user applies a "Class ID" filter from the filter pane
    Then the user should be able to see the available "Class IDs" in the filter pane