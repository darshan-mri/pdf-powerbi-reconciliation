Feature: Financial Hub Map

  Scenario: User interacts with the filter pane in the Power BI report
      Given User logs into Power BI
      And User selects the workspace
      When User opens the report
      And clicks on the "Filter show/hide" pane
      Then the following filter options should be displayed:
        | Period                |
        | Active Entities       |
        | Basis                 |
        | Balance Forward       |
        | Area Type             |
        | Mri Financial Format  |
        | Portfolio ID - Name   |
        | Project ID - Name     |
        | Entity Type           |
        | Entity ID - Name      |
        | Life Code             |
        | Property type         |
        | Property sub type     |
        | Class ID              |
        | Investment flag       |
        | Investment type       |
        | Location ID           |
        | State ID              |
        | Client Name           |
        | Suite Type            |
        | Owner                 |
        | Asset Manager         |
        | Department            |
        | State                 |
        | Region                |
        | Agent                 |
  
      And the following filter options should have default selections:
        | Period                | Current Period          |
        | Active Entities       | Is Y                    |
        | Basis                 | Is Accrual              |
        | Balance Forward       | N                       |
  
      And the filter options should update dynamically based on the selections made
      And the visuals should display relevant data based on the selected filter conditions