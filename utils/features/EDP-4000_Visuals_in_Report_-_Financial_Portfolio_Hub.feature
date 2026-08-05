Feature: Financial Portfolio Hub

  Scenario Outline: Verify Financial Portfolio Hub report loads correctly without breaking visuals
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    Then The report should load without breaking any of the following visuals:
      | As Of Date                                           |
      | Refreshed Date                                       |
      | Last Updated date icon                               |
      | User Guide icon                                      |
      | Revenues keycard                                     |
      | OpEx keycard                                         |
      | NOI keycard                                          |
      | Capex keycard                                        |
      | Net Cashflow keycard                                 |
      | Debt Service keycard                                 |
      | Non-OpEx keycard                                     |
      | <Keycard> (Actuals vs. STD Budget) line chart        |
      | <Keycard> (Actuals vs. STD Budget) table             |
      | <Keycard> Variance scatter chart                     |

    Examples:
      | Keycard     |
      | Revenues    |
      | OpEx        |
      | NOI         |
      | Capex       |
      | Net Cashflow|
      | Debt Service|
      | Non-OpEx    |