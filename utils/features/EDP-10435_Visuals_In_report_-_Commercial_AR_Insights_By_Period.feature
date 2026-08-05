Feature: Commercial AR Insights By Period - Visuals

  Scenario: Verify Commercial AR Insights By Period report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial AR Insights By Period" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Visual Name                                |
      | Total Open Charges keycard                 |
      | Total Billings keycard                     |
      | Total Credits keycard                      |
      | 1st Month keycard                          |
      | 2nd Month keycard                          |
      | 3rd Month keycard                          |
      | 4+ Month keycard                           |
      | Open Receivable Trend chart                |
      | Total Open AR by Year pie chart            |
      | Open Receivables Summary table              |
      | Monthly Trends bar graph                   |
      | Open Receivables by Transaction Year chart  |
      | Open Charges table                         |
      | Billing by Source table                    |
      | Open Receivable by State chart             |