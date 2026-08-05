Feature: Commercial AR Pattern by Report - Visuals
Scenario: User opens a report and visuals load without breakage
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the report should load the following visuals without any breakage:
      | As Of Date                                     |
      | Refresh Date                                   |
      | last data Update icon                          |
      | User Guide icon                                |
      | Total Open Charges keycard                     |
      | Total Billings keycard                         |
      | Total credits keycard                          |
      | 1st month keycard                              |
      | 2nd month keycard                              |
      | 3rd month keycard                              |
      | 4th month keycard                              |
      | Open Receivable trends chart                   |
      | Open Charges table                             |
      | Billing by source table                        |
      | Paid last month & This month keycard           |
      | Paid last month but not this month keycard     |
      | Paid last month but not billed this month keycard |
      | Not paid last month but paid this month keycard|
      | Not paid last month or this month keycard      |
      | Not paid last month not billed this month keycard |
      | Not billed last month but paid this month keycard |
      | Not billed this month not paid this month keycard |
      | Not billed last month or this month keycard    |
      | Total tenants keycard                          |
      | Tenant AR Patterns Table                       |
      | Open Receivables - Details Table               |