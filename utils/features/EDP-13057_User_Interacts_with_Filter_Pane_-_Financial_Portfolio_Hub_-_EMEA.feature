Feature: Filter Pane - Financial Portfolio Hub Report

  Scenario: User interacts with the filter pane
    Given the user logs into PowerBI with valid credentials
    And selects the appropriate Workspace
    When the user opens the 'Financial Portfolio Hub' Report
    And clicks on the Show/hide filter pane icon
    Then the user should see the following filter options in the Filter Pane:
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
      | Portfolio             |
      | Project               |
      | Entity Type           |
      | Entity Name           |
      | Life Code             |
      | Property Type         |
      | Property Sub Type     |
      | Class ID              |
      | Investment Flag       |
      | Invest Type           |
      | Location ID           |
      | State ID              |
      | Client Name           |
      | Suite Type            |
      | Owner                 |
      | Asset Manager         |
      | Department            |
      | Region                |
      | Balance Forward       |
      | Agent                 |
    
    And the default values should be selected for the following filters:
      | Filters             | Default Value     |
      | --------------      | ----------------- |
      | Period              | Current Period    |
      | Group by            | Entity Type       |
      | Group by (Level 2)  | Entity ID - Name  |
      | TimeFrame           | YTD               |
      | Active Entities     | Y                 |
      | Basis               | Accrual           |
      | Budget Type         | Std. Budget       |
      | Balance Forward     | N                 |
      
    When the user selects any of the filter options in the Filter Pane
    Then the visuals in the report should update dynamically based on the selection made