Feature: Residential Occupancy Reporting Range Selection in Power BI

  Scenario: User selects a Reporting Range in the Residential Occupancy report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Residential Occupancy report
    Then The user should be able to select the "MTD", "QTD", or "YTD" from the Reporting Range options