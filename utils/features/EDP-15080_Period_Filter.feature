Feature: Period and Date Filters in Commercial Reports

  Scenario: Validate priority order of Date, Current Period, Period, and Default logic
    Given User logs into PowerBI
    And User opens the Commercial reports from the workspace
    And User opens the filter pane
    Then the period and Date filters should be available in the filter pane

    # Step 1: Validate Date filter priority
    When User selects a specific date from the Date filter
    Then the measure should return the selected date
    And the Dashboard data should filter based on the returned date

    # Step 2: Validate Current Period when Date is not selected
    When User clears the Date filter
    And User selects a Period as CurrentPeriod
    Then the measure should return today's date
    And the Dashboard data should filter based on the returned date

    # Step 3: Validate Period selection when not current
    When User selects random Period except the CurrentPeriod
    Then the measure should return the end date of the selected Period month
    And the Dashboard data should filter based on the returned date

    # Step 4: Validate default fallback
    When User clears all filters
    Then the measure should return the maximum available date from the dataset
    And the Dashboard data should filter based on the returned date