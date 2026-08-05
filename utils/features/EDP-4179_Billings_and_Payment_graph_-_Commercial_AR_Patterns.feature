Feature: Commercial AR Patterns

  Scenario: Display and interact with billings and payment graph
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    When the user opens the "Commercial AR Patterns" report
    Then the report title should include the selected Reporting Range
    And the bar graph should be visible with correctly aligned X and Y axes
    And x axis should be sorted in descending Order
    And x axis should be labelled as 'Month & Year'
    And y axis should be labelled as 'Aged Billings and Aged Credits'
    When the user hovers over a bar in the graph
    Then a tooltip should appear displaying the following information:
      | Month and Year               |
      | Aged Billing/Credits         |
      | Charge Amount % Paid         |
      | Prior Month Charge % Diff    |
      | Prior Month Payments % Diff  |
  
    When the user selects any of the bars from the graph
    Then the information related to the selected bar should be displayed in key cards and other visuals