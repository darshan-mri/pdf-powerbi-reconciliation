Feature: Financial Portfolio Hub

  Scenario: User interacts with the NOI table and associated visuals
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from NOI keycard
    Then User sees the NOI table on scrolling down
    When User clicks Focus Mode icon from the NOI table
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page
    When User hovers over the Filters icon in the NOI table
    Then User should see the applied filters
    When User clicks on any of the column names in the NOI table
    Then User sees the values sorted based on the clicked column name
    When User selects any row in the NOI table
    Then the visuals and values should get updated in the NOI line stacked column combo chart and NOI scatter chart as per the selected row in the NOI table
    When User hovers over the bar of NOI line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period      |
      | NOI         |
      | Highlighted |
    When User hovers over the line of NOI line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the NOI table
    When User hovers over the scatter point in the NOI Variance scatter chart
    Then User should see tooltip with the following details:
      | Entity                   |
      | NOI Variance To Budget   |
      | NOI Variance To Budget % |
    And the tooltip values should match the selected row in the NOI table
    When User clicks again on the selected row
    Then User should see the selection is reverted
    And the values and visuals of NOI line stacked column combo chart and NOI variance scatter chart are also reverted