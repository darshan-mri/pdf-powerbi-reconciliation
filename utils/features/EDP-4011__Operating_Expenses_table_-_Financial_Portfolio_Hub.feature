Feature: Financial Portfolio Hub

  Scenario: User interacts with the Operating Expenses table and associated visuals
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Operating Expenses keycard
    Then User sees the Operating Expenses table on scrolling down
    When User clicks Focus Mode icon from the Operating Expenses table
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When User hovers over the Filters icon in the Operating Expenses table
    Then User should see the applied filters
    When User clicks on any of the column names in the Operating Expenses table
    Then User sees the values sorted based on the clicked column name
    When User selects any row in the Operating Expenses table
    Then the visuals and values should get updated in the Operating Expenses line stacked column combo chart, Operating Expenses scatter chart, and keycards as per the selected row in the Operating Expenses table
    When User hovers over the bar of the Operating Expenses line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period             |
      | Operating Expenses |
      | Highlighted        |
    When User hovers over the line of the Operating Expenses line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the Operating Expenses table
    When User hovers over the scatter point in the Operating Expenses Variance scatter chart
    Then User should see tooltip with the following details:
      | Entity |
      | Operating Expenses Variance To Budget   |
      | Operating Expenses Variance To Budget % |
    And the tooltip values should match the selected row in the Operating Expenses table
    When User clicks again on the selected row
    Then User should see the selection is reverted
    And the values and visuals of the Operating Expenses line stacked column combo chart and Operating Expenses variance scatter chart are also reverted