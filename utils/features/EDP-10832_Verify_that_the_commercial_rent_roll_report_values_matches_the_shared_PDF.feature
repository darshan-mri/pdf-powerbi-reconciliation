Feature: Commercial AR Insights by period
  
  Scenario: Verify that Total units keycard values from Commercial rent roll report matches with the shared PDF
    Given User logs into Power BI
    And User Selects appropriate workspace
    When User opens Commercial rent roll report
    Then total units keycard values should match with values in PDF