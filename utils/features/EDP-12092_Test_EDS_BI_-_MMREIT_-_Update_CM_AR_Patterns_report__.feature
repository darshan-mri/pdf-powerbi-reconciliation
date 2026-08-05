Feature: Test Client ML Realty for Commercial AR Pattern by Period

Scenario: Sum of all 9 Keycard values are equal to Total Tenants
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  Then User should sees 9 <Keycard> with correct value
  And sum of values from all 9 <Keycard> is equal to the Total Tenants
  | Keycard |
  | Paid last month & This month Keycard              |
  | Paid last month but not this month Keycard        |
  | Paid last month but not billed this month Keycard |
  | Not paid last month but paid this month Keycard   |
  | Not paid last month or this month Keycard         |
  | Not paid last month not billed this month Keycard |
  | Not billed last month but paid this month Keycard |
  | Not billed this month not paid this month Keycard |
  | Not billed last month or this month Keycard       |