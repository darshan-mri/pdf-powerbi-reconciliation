Feature: Financial Portfolio Hub - Capex Expenses

  Scenario: User interacts with the Capex table and associated visuals
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Capex keycard
    Then User sees the Capex table on scrolling down

    When User clicks Focus Mode icon from the Capex table
    Then the visual should be displayed in full screen with the values intact and a back button to navigate back to the home page

    When User hovers over the Filters icon in the Capex table
    Then User should see the applied filters

    When User clicks on any of the column names in the Capex table
    Then User sees the values sorted based on the clicked column name

    When User selects any row in the Capex table
    Then the visuals and values should get updated in the Capex line stacked column combo chart and Capex scatter chart as per the selected row in the Capex table

    When User hovers over the bar of Capex line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period      |
      | Capex       |
      | Highlighted |

    When User hovers over the line of Capex line stacked column combo chart
    Then User sees tooltip with the following details:
      | Period |
      | Budget |
    And the tooltip values should match the selected row in the Capex table

    When User hovers over the scatter point in the Capex Variance scatter chart
    Then User should see tooltip with the following details:
      | Entity                     |
      | Capex Variance To Budget   |
      | Capex Variance To Budget % |
    And the tooltip values should match the selected row in the Capex table

    When User clicks again on the selected row
    Then User should see the selection is reverted
    And the values and visuals of Capex line stacked column combo chart and Capex variance scatter chart are also reverted