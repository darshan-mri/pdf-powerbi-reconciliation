Feature: Residential Lease Expiration - Lease Expiry Period Filter

  Scenario: User selects an expiry period and the report updates accordingly
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And Selects any of the Expiry Periods from the Lease Expiry Period slicer
    Then The report should be displayed based on the expiry period selected