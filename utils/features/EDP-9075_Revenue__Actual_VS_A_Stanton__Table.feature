Feature: B&F Financial Portfolio Hub

  Scenario: Verify Revenue table and related visuals interactions
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    And the user clicks on the Revenues keycard
    Then the user sees the Revenue table on scrolling down
    When the user clicks the Focus Mode icon from the Revenue table
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When the user hovers over the Filters icon in the Revenue table
    Then the user should see the applied filters
    When the user clicks on any of the column names in the Revenue table
    Then the user sees the values sorted based on the clicked column name
    When the user selects any row in the Revenue table
    Then the visuals and values should get updated in the Revenue line stacked column combo chart and Revenue scatter chart as per the selected row in the Revenue table
    When the user hovers over the bar of the Revenue line stacked column combo chart
    Then the user sees a tooltip with the following details:
      | Period  |
      | Revenue |
    When the user hovers over the line of the Revenue line stacked column combo chart
    Then the user sees a tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the Revenue table
    When the user hovers over the scatter point in the Revenue Variance scatter chart
    Then the user should see a tooltip with the following details:
      | Entity                           |
      | B&F Revenue Variance To Variance |
      | B&F Revenue Variance To Variance % |
    And the tooltip values should match the selected row in the Revenue table
    When the user clicks again on the selected row
    Then the user should see the selection reverted
    And the values and visuals of the Revenue line stacked column combo chart and Revenue Variance scatter chart also reverted