Feature:Residential Occupancy & Rent Instights - Display Average Monthly Rent in Power BI

  Scenario: User views Average Monthly Rent Keycard with Reporting Range and Comparison
    Given User logs into Power BI
    When User selects the "WorkSpace"
    And User clicks on the "Residential Occupancy & Rent Insights Report"
    Then Average Monthly Rent should be displayed based on the selected <Reporting Range>
      | QTD |
      | YTD |
    And Average Monthly Rent value should be displayed as 0 if the value is 0, not as (blank)
    And Average Monthly Rent visual should display the previous year's comparison value