Feature: Interactions with the Non-OpEx Table and Visuals in Financial Portfolio Hub

  Scenario: User interacts with the Non-OpEx table and updates visuals accordingly
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Non-OpEx keycard
    Then User sees the Non-OpEx table on scrolling down

    When User clicks Focus Mode icon from the Non-OpEx table
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page

    When User hovers over the Filters icon in the Non-OpEx table
    Then User should see the applied filters

    When User clicks on any of the column names in the Non-OpEx table
    Then User sees the values sorted based on the clicked column name

    When User selects any row in the Non-OpEx table
    Then the visuals and values should get updated in the Non-OpEx line stacked column combo chart and Non-OpEx scatter chart as per the selected row in the Non-OpEx table

    When User hovers over the bar of Non-OpEx line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period      |
      | Non-OpEx    |
      | Highlighted |

    When User hovers over the line of Non-OpEx line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the Non-OpEx table

    When User hovers over the scatter point in the Non-OpEx Variance scatter chart
    Then User should see tooltip with the following details:
      | Entity                        |
      | Non-OpEx Variance To Budget   |
      | Non-OpEx Variance To Budget % |
    And the tooltip values should match the selected row in the Non-OpEx table

    When User clicks again on the selected row
    Then User should see the selection is reverted
    And the values and visuals of Non-OpEx line stacked column combo chart and Non-OpEx variance scatter chart are also reverted