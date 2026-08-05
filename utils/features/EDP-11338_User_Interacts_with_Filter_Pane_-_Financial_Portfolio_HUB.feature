Feature: Financial Portfolio Hub

  Scenario: User interacts with the filter pane in the Power BI report
      Given User logs into Power BI
      And User selects the workspace
      When User opens the report
      And clicks on the "Filter show/hide" pane
      Then the following filter options should be displayed:
        | Filters               |
        |-----------------------|
        | Period                |
        | Group by              |
        | Group by (Level 2)    |
        | Timeframe             |
        | Active Entities       |
        | Basis                 |
        | Budget Type           |
        | Ledger Code           |
        | MRI Financial Format  |
        | Entity ID - Name      |
        | Entity Type           |
        | Life Code             |
        | Property Type         |
        | Property Sub Type     |
        | Class ID              |
        | Investment Flag       |
        | Investment Type       |
        | Location ID           |
        | State ID              |
        | Client Name           |
        | Suite Type            |
        | Owner                 |
        | Asset Manager         |
        | Department            |
        | Region                |
        | Portfolio ID - Name   |
        | Balance Forward       |
        | Agent                 |
  
      And the following filter options should have default selections:
        | Period                | Current Period          |
        | Active Entities       | Is Y                    |
        | Basis                 | Is Accrual              |
        | Group BY              | Entity type             |
        | Group BY (Level 2)    | Entity ID - Name        |
        | Timeframe             | YTD                     |
        | Budget Type           | STD.budget              |
        | Balance Forward       | N                       |

      And the filter options should update dynamically based on the selections made
      And the visuals should display relevant data based on the selected filter condition