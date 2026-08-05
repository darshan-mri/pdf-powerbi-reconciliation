Feature: Commercial Occupancy - WALE Keycard Display

  Scenario: Blank value displayed when Date and Period Filter is not set
    Given the user logs into PowerBI
    And the user opens the Comemrcial Occupancy report
    Then Visuals in the report should load successfully
    When the user does not set any value in the Date and Period Filter
    Then the WALE Keycard should display value as Blank