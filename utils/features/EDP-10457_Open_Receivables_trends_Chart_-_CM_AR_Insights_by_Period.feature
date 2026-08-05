Feature: Commercial AR Insights by Period - Open Receivables trends chart
  
Scenario: User views and interacts with the Open Receivables Trends chart
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the Commercial AR Insights by Period report
    Then the user should see the data loaded properly for the Open Receivables Trends Stacked Column chart
    And Month-Year should be sorted in descending order
    And Month-Year should be restricted based on the selected period
    And hovering over a bar should display a tooltip with the corresponding value:
      | Month-Year                                   |
      | OpenCharges / Credis / Billings              |
      | % of Charges (value) Open                    |
      | % of Charges (value) Received or Adjustments |
    When the user selects any of the bars from the chart
    Then the information related to the selected bar should be displayed in key cards and other visuals
    And the user right-clicks on the bars and selects "Show as a table"
    Then the corresponding open Charge values should be displayed in tabular format