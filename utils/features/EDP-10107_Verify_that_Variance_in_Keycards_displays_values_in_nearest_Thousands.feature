Feature: Variance in Keycards - Display Values in Nearest Thousands

  Scenario: Verify that Variance in Keycards displays values in nearest Thousands
    Given User logs into PowerBI
    When User selects the appropriate Workspace
    And User clicks on the Financial NOI Analysis Report
    Then User should be able to see the <Keycards> with appropriate values
    And Variance in the <Keycards> should display values in nearest thousands (e.g., in 'k')
    
   
      | Keycards             |
      | Revenue              |
      | Operating Expense    |
      | Net Operating Income |