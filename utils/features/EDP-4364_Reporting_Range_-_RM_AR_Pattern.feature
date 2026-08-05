Feature: Residential AR Pattern

  Scenario: Verifying date range selection and data display
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the default date range should be set to Trailing 3 months
    When the user selects any of the date ranges
    Then the data related to the selected range should be displayed in key cards and other visuals