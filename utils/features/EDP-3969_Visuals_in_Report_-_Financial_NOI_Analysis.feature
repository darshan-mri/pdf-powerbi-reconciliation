Feature: Financial NOI Analysis

  Scenario: Load Financial NOI Analysis report successfully
    Given User logs into PowerBI
    And User selects the workspace
    When User opens the Financial NOI Analysis report
    Then the report should load without breaking any of the following visuals:
      | As Of Date                                                  |
      | Refreshed Date                                              |
      | Last Updated date icon                                      |
      | User Guide icon                                             |
      | Revenue Keycard                                             |
      | Operating Expense Keycard                                   |
      | Net Operating Income Keycard                                |
      | NOI by Entity YTD (Actuals vs. Budget) line clustered chart |
      | YTD Revenue (Actuals MTD vs. Budget) Total Revenue, Rent, Recovarable income, Other Income line chart |
      | OPEX (Actuals MTD vs. Budget) Total Opex, NON - Recovarable OPEX, Total OPEX line chart |
      | NOI Variance Breakdown table                                |