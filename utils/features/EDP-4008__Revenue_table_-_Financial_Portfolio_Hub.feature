Feature: Financial Portfolio Hub

  Scenario: User interacts with the Revenue Table and associated visuals
    Given User logs into Power BI
    When User opens the Financial Portfolio Hub report from the workspace
    And User opens More Details from the Revenues keycard
    Then User sees the Revenue table and line stacked column combo chart on scrolling down
    And the X and Y axes should be properly labeled as "Period" and "Revenue" respectively
    When User clicks the Focus Mode icon from the Revenue table
    Then the visual should be displayed in full screen with the values intact
    And there should be a back button to navigate back to the home page
    When User hovers over the Filters icon in the Revenue table
    Then User should see the applied filters
    When User clicks on any of the column names in the Revenue table
    Then User sees the values sorted based on the clicked column name
    When User selects any row in the Revenue table
    Then the visuals and values in the Revenue line stacked column combo chart, Revenue scatter chart, and the keycard should update based on the selected row in the Revenue table
    When User hovers over the bar in the Revenue line stacked column combo chart
    Then User sees a tooltip with the following details:
      | Period      |
      | Revenue     |
      | Highlighted |
    When User hovers over the line in the Revenue line stacked column combo chart
    Then User sees a tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the Revenue table
    When User hovers over the scatter point in the Revenue Variance scatter chart
    Then User should see a tooltip with the following details:
      | Entity                           |
      | Revenue Variance To Budget       |
      | Revenue Variance To Budget %     |
    And the tooltip values should match the selected row in the Revenue table
    When User clicks again on the selected row
    Then User should see the selection is reverted
    And the values and visuals of the Revenue line stacked column combo chart and Revenue variance scatter chart should also be reverted