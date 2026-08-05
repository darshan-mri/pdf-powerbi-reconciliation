Feature: Residentials Occupancy and Rent Insights

  Scenario: Ensuring the report loads without breaking any visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The report should load without breaking any visuals