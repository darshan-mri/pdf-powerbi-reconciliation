Feature: Class ID Filter

  Scenario: User interacts with Class ID Filter
    Given the user logs into Power BI
    And the user selects a workspace
    When the user opens a report
    Then the user should see the "Future Vacancy Analysis" bar graph visual without any breakage
    And the user should see the following options on the visual:
      | Building ID - Name |
      | Regional Manager   |
      | Property Manager   |
      | Class ID           |
      | Property ID - Name |
    When the user selects the "Class ID" option
    Then the "Future Vacancy Analysis" visual should be updated according to the selected option
    When the user applies a "Class ID" filter from the filter pane
    Then the user should be able to see the available "Class IDs" in the filter pane