Feature: Residential AR Insights by period

  Scenario: User opens the Financial Report and verifies the visuals without breakage
      Given User logs into Power BI
      And User selects the workspace
      When User opens the report
      Then The User should be able to see the following visuals without any breakage:
        | As Of Date                        |
        | Updated Date                      |
        | Billing keycard                   |
        | Credits Keycard                   |
        | OpenCharges Keycard               |
        | Security Applied                  |
        | 1st month keycard                 |
        | 2nd Month keycard                 |
        | 3rd Month Keycard                 |
        | >= 4th month Keycard              |
        | Open Receivable Trends Chart      |
        | Total Open AR By Year Pie Chart   |
        | Monthly Trends Chart              |
        | Monthly Trends Details table      |
        | Open Receivables By Transaction Year |
        | Open By Source table              |
        | Billings Table                    |
        | Open Receivables By State         |