Feature: B&F Financial Portfolio Hub

  Scenario: Verify NOI table and related visuals interactions
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    And the user clicks on the NOI keycard
    Then the user sees the NOI table on scrolling down
    When the user clicks the Focus Mode icon from the NOI table
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When the user hovers over the Filters icon in the NOI table
    Then the user should see the applied filters
    When the user clicks on any of the column names in the NOI table
    Then the user sees the values sorted based on the clicked column name
    When the user selects any row in the NOI table
    Then the visuals and values should get updated in the NOI line stacked column combo chart and NOI scatter chart as per the selected row in the NOI table
    When the user hovers over the bar of the NOI line stacked column combo chart
    Then the user sees a tooltip with the following details:
      | Period |
      | NOI    |
    When the user hovers over the line of the NOI line stacked column combo chart
    Then the user sees a tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the NOI table
    When the user hovers over the scatter point in the NOI Variance scatter chart
    Then the user should see a tooltip with the following details:
      | Entity name |
      | Variance    |
      | Variance %  |
    And the tooltip values should match the selected row in the NOI table
    When the user clicks again on the selected row
    Then the user should see the selection reverted
    And the values and visuals of the NOI line stacked column combo chart and NOI Variance scatter chart also reverted