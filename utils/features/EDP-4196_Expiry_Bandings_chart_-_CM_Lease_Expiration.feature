Feature: Commercial Lease Expiration Report

  Scenario: Viewing and interacting with the Expiry Banding pie chart
    Given the user logs into Power BI
    And has selected appropriate workspace
    When the user opens the "Commercial Lease Expiration" report
    Then the "Expiry Banding" pie chart should display the distribution of different expiry bands
    And hovering over a section should show a tooltip with additional information about that expiry band
      | Year             |
      | Number of Suites |
    When the user selects any segment from the chart
    Then the Lease Details table and Lease Expiration Units chart should display information related to the selected segment