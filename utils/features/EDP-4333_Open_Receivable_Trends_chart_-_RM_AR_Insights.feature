Feature: Residential AR Insights

  Scenario: Verifying chart interaction and tooltip display
    Given the user logs into Power BI
    And the user selects the desired workspace
    When the user opens the "Residential AR Insights" report
    And the user selects a bar from the chart
    Then the corresponding data for the selected bar should be displayed in key cards and other visuals
    When the user hovers over a bar in the chart
    Then a tooltip should be displayed showing the following values:
      | Month - Year                         |
      | Aged Open Charges/Credits/Billings   |
      | % of Charges (Value) Open            |
      | % of Charges (Value) Received        |
    And x-axis should be sorted in descending order