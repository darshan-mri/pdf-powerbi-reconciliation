Feature: Residential AR Insights By Period

  Scenario: User views Residential AR Insights By Period on the filled map and interacts with data points
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The filled map with proper data points should be loaded
    When User hovers over a data point
    Then A tooltip with relevant information should be displayed
    When User selects any of the states from the map
    Then The relevant data should be displayed in key cards and other visuals