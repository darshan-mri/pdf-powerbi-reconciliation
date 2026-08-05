Feature: User Interactions with Financial NOI Analysis Report

  Scenario: User interacts with the NOI Variance Breakdown table and related charts
    Given User logs into PowerBI
    And User opens the Financial NOI Analysis report from the workspace
    When User selects any row from the NOI Variance Breakdown table
    Then The selected row should be highlighted and the opacity of the rest of the rows should be reduced
    And The visuals of the NOI by Entity chart and Revenue/OpEx chart should be updated as per the selected row
    When User hovers over any of the selected or unselected lines of the NOI by Entity chart
    Then User sees a tooltip with the following details:
      | Period         |
      | Comparison     |
      | Actual Revenue |
    When User hovers over any of the points in the Revenue or OpEx charts
    Then User sees a tooltip with the following details:
      | Period                    |
      | Actual Operating Expenses |
      | Comparison                |