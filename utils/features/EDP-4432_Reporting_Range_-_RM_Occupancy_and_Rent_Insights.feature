Feature: Residentials Occupancy and Rent Insights

  Scenario Outline: Selecting reporting ranges and viewing corresponding data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The user should be able to select the Reporting ranges
    When The user selects the <Reporting Ranges>
    Then The data corresponding to the selected range should be displayed in key cards and other visuals
    And The key cards Avg Occupancy % and Avg Monthly Rent should be suffixed with the reporting range selected
    Examples:
      | Reporting Ranges |
      | QTD              |
      | YTD              |