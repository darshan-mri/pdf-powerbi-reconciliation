Scenario: User views the report in Power BI workspace
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should be able to see the following visuals without any breakage:
      | As Of date                                       |
      | Reporting Range                                  |
      | Total Open Charges keycard                       |
      | Billings credit card                             |
      | Credit/Payments keycard                          |
      | Open Charges keycard                             |
      | Billing and payments table                       |
      | Billing and payments bar chart                   |
      | Paid last month and this month keycard           |
      | Paid last month but not this month keycard       |
      | Paid last month not billed this month keycard    |
      | Not paid last month but paid this month keycard  |
      | Not paid last month or this month keycard        |
      | Not paid last month not billed this month keycard |
      | Not billed last month paid this month keycard     |
      | Not billed last month not paid this month keycard |
      | Not billed last month or this month keycard      |
      | Tenant AR Pattern table                          |
      | Open Recivables - Details                        |