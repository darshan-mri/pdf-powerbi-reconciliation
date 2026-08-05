Feature: Display Signs for Variance in Variance Details Table
Scenario Outline: User views variance details table with correct values and signs
    Given User logs into PowerBI
    And User selects Workspace
    When User opens the report
    Then User should see the Variance Details table
    And The Net Operating Income, Non Operating Expenses, and Net Operating Income in the Variance Details table should appear as shown in the PDF with the "<Sign>" sign

    Examples:
      | Sign     |
      | Positive |
      | Negative |