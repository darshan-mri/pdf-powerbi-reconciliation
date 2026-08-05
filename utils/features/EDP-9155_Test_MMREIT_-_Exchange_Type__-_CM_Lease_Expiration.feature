Feature: Lease Data Filtering

  Scenario: User filters the lease data by currency type
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then User should be able to see the Exchange Type dropdown with the currency options
    When User selects a currency type
    Then The Lease expiration chart and lease details table should update with the following columns:
      | Monthly Rent         |
      | Monthly RPSF         |
      | Monthly Other Income |