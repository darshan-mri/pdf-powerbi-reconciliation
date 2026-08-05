Feature: Commercial AR Insights by Period - Period Filter Interaction - FRAPORT

  Scenario: User selects the Period filter and sees updated visuals
    Given the user logs into PowerBI
    And the user selects the customer name "Fraport"
    And the user opens the Commercial AR Insights by Period report
    When the user selects the Period filter from the Filters pane
    Then the visuals should update and display values according to the selected Period filter
    And a new filter option for "Prior Period" should be available on the Period Filter
    And by default, the Period filter should be set to "Prior Period"
    And the report data should display the previous month’s values
    And users should be able to switch seamlessly between "Current Period," "Prior Period," and other available periods without errors