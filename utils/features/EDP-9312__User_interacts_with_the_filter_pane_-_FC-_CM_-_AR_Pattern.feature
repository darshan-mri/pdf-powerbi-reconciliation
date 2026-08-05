Scenario: Applying filters in the report with default selections
    Given The user logs into Power BI
    And The user selects the workspace
    When The user opens the report
    And The user clicks on the "Filter show/hide" pane
    Then The following filter options should be displayed:
      | Filter Name               |
      | Date                      |
      | Group By                  |
      | Hyrarchy Name             |
      | Group By (Level 2)        |
      | Portfolio                 |
      | Entity Type               |
      | Life Code                 |
      | Property Type             |
      | Property Sub Type         |
      | Class ID                  |
      | Investment flag           |
      | Investment Type           |
      | Location ID               |
      | Client Name               |
      | State ID                  |
      | Suite Type                |
      | Company group             |
      | Owner                     |
      | Asset Manager             |
      | Department                |
      | Manager                   |
      | landLord                  |
      | Master occupant           |
      | store category            |
      | tenent Type               |
      | Tenent Type category      |
      | Income Category           |
      | SIC Code                  |
      | Entity Type ID            |
      | Suite status              |
      | Building ID - Name        |
      | Is ActiveBuilding         |
      | Income category ID        |
      | Acquisition Date          |
      | Disposition Date          |
    And The following filters should be selected by default:
      | Filter Name         | Default Selection        |
      | Date                | Current Date             |
      | Income category ID  | Is Not PPR,PPT,SDP or UC |
      | Group by            | Entity Type              |
      | Hyrarchy name       | Client hyrarchy          |
      | Group By (level 2)  | Building ID Name         |
    When The user applies filters from the filter pane
    Then The visuals in the report should be updated
    And The values should be displayed according to the selected filters