Feature: Commercial Stacking Plan - Building Selector Dropdown

  Scenario: User views data for selected building
    Given the user logs into Power BI
    And selects the appropriate workspace
    When the user opens the 'Commercial Stacking Plan report'
    Then the 'Select All' option should not be available in the Building Selector dropdown
    And by default all the checkboxes in the building selector dropdown should be unchecked
    And the Building Selector Dropdown should be configured to single selection
    When the user selects any of the Building ID - Name from the Building Selector dropdown
    Then the data for the selected Building ID - Name should be displayed in <Key Card> and <Other Visual>
    When the User Unchecked the selected Building ID - Name from the Building Selector dropdown
    Then the <key Card> and <Other Visual> should be changed to default selection

      | Key Card         |
      | ---------------  |
      | Total Units      |
      | Vacant Units     |
      | Year 1 Units     |
      | Year 2 Units     |
      | Year 3 Units     |
      | Year 4+ Units    |
      | Holdover/MTM     |
      
      | Other Visual            |
      | ----------------------- |
      | Stacking Plan Chart     |
      | Stacking Table          |
      | Unit Information Chart  |