Feature: Filter Pane FC Financial Details
Scenario: Applying filters in the report with default selections
    Given The user logs into Power BI
    And The user selects the workspace
    When The user opens the report
    And The user clicks on the "Filter show/hide" pane
    Then The following filter options should be displayed:
      | Filter Name               |
      | Period                    |
      | Variance Type             |
      | Active Entities           |
      | Basis                     |
      | MRI Financial Format      |
      | Portfolio Name            |
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
      | Suite Name                |
      | Owner                     |
      | Asset Manager             |
      | Department                |
      | Region                    |
      | Project ID - Name         |
      | Entity ID - Name          |
      | Balance Forward           |
      | Property ID - Name        |
      | Acquisition Date          |
      | Disposition Date          |
    And The following filters should be selected by default:
      | Filter Name         | Default Selection        |
      | Period              | Current Period           |
      | Variance Type       | Blended Forecast         |
      | Group by            | Entity ID - Name         |
      | Active   Entities   | Y                        |
      | Basis               | Accrual                  |
    When The user applies filters from the filter pane
    Then The visuals in the report should be updated
    And The values should be displayed according to the selected filters