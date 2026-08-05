Feature: Financial Details + Report Load Integrity

  Scenario: User opens Financial Details report without breaking any visuals
    Given User logs into PowerBI
    And User selects the workspace
    When User opens Financial Details report
    Then the report should load without breaking any of the following visuals
      | As Of Date                     |
      | Refreshed Date                 |
      | Last Updated date icon         |
      | User Guide icon                |
      | YTD Variance % line graph      |
      | Blended Forecast table         |
      | Variance Details table         |
      | Blended Forecast Details table |
      | YTD Comparision table          |
      | YTD Comparision details table  |