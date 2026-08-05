Feature: Commercial Occupancy

  Scenario: Interact with bar graph in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the bar graph title suffixed with the Absorption YTD sum should be displayed
    And the x and y axes representing the categories should be aligned properly
    And hovering over a bar should display the tooltip values
    When the user selects any of the bars from the bar graph
    Then the data related to the selected bar should be displayed in occupancy details and occupancy % visuals