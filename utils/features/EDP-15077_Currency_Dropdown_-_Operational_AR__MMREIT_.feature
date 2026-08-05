Feature: Currency Exchange Visual Interaction – Operational AR

  Scenario: Display and Conversion Behavior for Currency Selection in Operational AR Dashboard
    Given the user logs into Power BI
    And selects Customer "MMREIT"
    And the user opens the Operational AR Dashboard
    Then the Currency Dropdown should default to "Original Currencies"

    When the user selects a currency from the Currency Dropdown
      | Currency              |
      | Mexican Pesos (MXN)   |
      | Original Currencies   |
      | US Dollars (USD)      |
    Then the dashboard should update all monetary values based on the selected currency

    And if the user selects "US Dollars (USD)"
    Then all transactions originally recorded in MXN should be converted to USD using the applicable exchange rate
    And the displayed currency symbol should be "$"

    And if the user selects "Mexican Pesos (MXN)"
    Then all transactions originally recorded in USD should be converted to MXN using the applicable exchange rate
    And the displayed currency symbol should be "$"

    And if the user selects "Original Currencies"
    Then all transactions should appear in their native/original currency without conversion
    And the displayed currency symbol should be "$"