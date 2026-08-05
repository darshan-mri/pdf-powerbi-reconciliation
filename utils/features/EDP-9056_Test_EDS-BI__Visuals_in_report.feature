Feature: B&F Financial Portfolio Hub

  Scenario: Verify report visuals load correctly
    Given the user logs into Power BI
    When the user opens the Financial Portfolio Hub report from the workspace
    And the user opens the Financial NOI Analysis report
    Then the report should load without breaking any of the following visuals:
      | Revenues keycard                                |
      | OpEx keycard                                    |
      | NOI keycard                                     |
      | Capex keycard                                   |
      | Net Cashflow keycard                            |
      | Debt Service keycard                            |
      | Non-OpEx keycard                                |
      | Revenue (Actuals vs. A. Santon) line chart      |
      | Revenue (Actuals vs. A. Santon) table           |
      | Revenue (Actuals vs. A. Santon) scatter chart   |