Feature: Commercial AR Pattern - Visuals

  Scenario: Verify Commercial AR Patterns report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial AR Pattern" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Reporting Range                                     |
      | Total Open Charges keycard                          |
      | Billings keycard                                    |
      | Credits keycard                                     |
      | Open Charges keycard                                |
      | Billings and Payments - Current Month Bar Graph     |
      | Billings and Payments - Current Month Bar Table     |
      | Tenant AR Patterns Table - Current Month            |
      | Open Receivable Details table                       |
      | Paid last Month & This Month Key card               |
      | Paid Last Month Not Billed This Month Key Card      |
      | Paid Last Month But Not This Month Key Card         |
      | Not Paid Last Month or This MonthKey Card           |
      | Not Paid Last Month Not Billed This Month Key Card  |
      | Not Paid Last Month But Paid This Month key Card    |
      | Not Billed Last Month Paid This Month Key Card      |
      | Not Billed Last Month or This Month Key Card        |
      | Not Billed Last Month Not Paid This Month Key Card  |