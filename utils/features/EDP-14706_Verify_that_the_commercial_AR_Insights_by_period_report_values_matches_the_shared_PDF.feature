Feature: Commercial AR Insights by period
  
  Scenario: Verify that Total amount/1st/2nd/3rd/4+ months keycard values from Commercial AR insights by period report matches with the shared PDF
    Given User logs into Power BI
    And User Selects appropriate workspace
    When User opens Commercial AR Insights by period
    Then Total amount/1st/2nd/3rd/4+ months keycard keycard values should match with values in PDF