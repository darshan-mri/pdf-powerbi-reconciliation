Feature: Commercial AR Insights - Visuals
  
  Scenario: Verify Commercial AR Insights report loads correctly without breaking visuals
    Given User logs into PowerBI
    When User opens Commercial AR Insights report from the workspace
    Then The report should load without breaking any of the following visuals:
      | Reporting Range                                     |
      | Total Open Charges keycard                          |
      | Billings keycard                                    |
      | Credits keycard                                     |
      | Open Charges keycard                                |
      | Open receivable trend chart                         |
      | Total Open Charges details table                    |
      | Billings details Table                              |
      | Credits details Table                               |
      | Open charges details Table                          |
      | Total Open AR by year Pie chart                     |
      | Open Receivable summary table                       |
      | Monthly Trends Bar Graph                            |
      | Open Receivable By Transaction Year                 |
      | Open Receivables Details Table                       |
      | Open Receivables By State                            |