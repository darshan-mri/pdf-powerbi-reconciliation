Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User interacts with Financial NOI Analysis report
    Given User logs into PowerBI
    When User opens Financial NOI Analysis report from the workspace
    Then User should see the following legends in the chart:
      | Net Operating Income Actuals |
      | NOI Budget                   |
    And User should see the amount range slider for the Y axis of the chart
    And User should see the Entity names on the X axis of the chart
    
    When User moves the amount range slider
    Then User should see the lines in the chart update based on the slider amount range
    
    When User hovers over the NOI Actuals line in the chart
    Then User should see a tooltip with the following details:
      | Entity ID - Name             |
      | Net Operating Income Actuals |
    And The values in the tooltip should match the values in the NOI Variance Breakdown table
    
    When User hovers over the NOI Budget line in the chart
    Then User should see a tooltip with the following details:
      | Entity ID - Name      |
      | NOI Budget            |
    And The values in the tooltip should match the values in the NOI Variance Breakdown table
    
    When User selects any line in the NOI by Entity chart
    Then The selected line should be highlighted and the opacity of the unselected lines should be reduced
    And The visuals and values should be updated in the Revenue (Actuals v. Budget) line chart, Operational Expenses line chart, and NOI Variance Breakdown table according to the selected line
    
    When User hovers over the selected line in the chart
    Then The tooltip values should be displayed and should match the values in the NOI Variance Breakdown table