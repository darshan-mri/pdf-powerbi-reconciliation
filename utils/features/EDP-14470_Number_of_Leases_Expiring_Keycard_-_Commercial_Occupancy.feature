Feature: Number of Leases Expiring KeyCard - Commercial Occupancy

  Scenario: User views Number of Leases Expiring KeyCard
    Given User is logged into PowerBI
    And User selects the appropriate Workspace
    When User opens the Commercial Occupancy Report
    Then Number of Leases Expiring KeyCard should be visible with the following segregations:
      | 0 - 90 Days    |
      | 91 - 180 Days  |
      | 181 - 365 Days |
    And The totals displayed in the report should match with the Year 1 of Expiry Bandings chart in the Commercial Lease Expiration Report