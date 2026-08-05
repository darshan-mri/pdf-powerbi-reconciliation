Scenario: Applying filters in the report with default selections
    Given The user logs into Power BI
    And The user selects the workspace
    When The user opens the report
    And The user clicks on the "Filter show/hide" pane
    Then The following filter options should be displayed:
      | Filter Name               |
      | Date                      |
      | Suite sq.ft               |
      | Portfolio                 |
      | Project                   |
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
      | Property Name             |
      | Suite status              |
      | Building ID - Name        |
      | occupancy status          |
      | Acquisition Date          |
      | Disposition Date          |
      
    And The following filters should be selected by default:
      | Filter Name         | Default Selection        |
      | Date                | Current Date             |
      | Suite sq.ft         | Is Greater Than 0        |
      
    When The user applies filters from the filter pane
    Then The visuals in the report should be updated
    And The values should be displayed according to the selected filters