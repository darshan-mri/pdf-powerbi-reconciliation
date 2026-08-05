Feature: Financial GL Details EMEA

  Scenario: User interacts with the filter pane in the Power BI report
      Given User logs into Power BI
      And User selects the workspace
      When User opens the report
      And clicks on the "Filter show/hide" pane
      Then the following filter options should be displayed:
        | Periods               |
        | Active Entities       |
        | Basis                 |
        | MRI Financial Format  |
        | GL Reference          |
        | GL Description        |
        | Account Number        |
        | Account Name          |
        | Portfolio             |
        | Project               |
        | Entity Type           |
        | Entity Name           |
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
        | Departent             |
        | Region                |
        | GL Source             |
        | Agent                 |
  
      And the following filter options should have default selections:
        | Periods               | Current Period          |
        | Active Entities       | Is Y                    |
        | Basis                 | Is Accrual              |
  
      And the filter options should update dynamically based on the selections made
      And the visuals should display relevant data based on the selected filter conditions