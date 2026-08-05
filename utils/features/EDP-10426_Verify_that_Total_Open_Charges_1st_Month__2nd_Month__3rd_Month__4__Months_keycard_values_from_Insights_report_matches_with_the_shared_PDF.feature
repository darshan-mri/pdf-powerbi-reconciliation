Feature: Commercial AR Insights by period
  
  Scenario: Verify that Total Open Charges,1st Month, 2nd Month, 3rd Month, 4+ Months keycard values from Insights report matches with the shared PDF
    Given User logs into Power BI
    And User Selects appropriate workspace
    When User opens Redico - Commercial AR Insights by Period report
    Then 1st Month, 2nd Month, 3rd Month, 4+ Months keycard values should match with values in PDF