Feature: Filter Pane - Financial NOI Analysis Report APAC

  Scenario: User interacts with the filter pane
    Given the user logs into PowerBI with valid credentials
    And selects the appropriate Workspace
    When the user opens the 'Financial NOI Analysis' Report
    And clicks on the Show/hide filter pane icon
    Then the user should see the following filter options in the Filter Pane:
      | Filters               |
      |-----------------------|
      | Period                |
      | Reporting             |
      | TimeFrame             |
      | Basis                 |
      | Budget Type           |
      | Group by              |
      | Variance Type         |
      | Group by (Level 2)    |
      | Active Entities       |
      | MRI Financial Format  |
      | Portfolio             |
      | ProjectID - Name      |
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
      | Ledger Code           |
      | Balance Forward       |
      
    And the default values should be selected for the following filters:
      | Filters           | Default Value     |
      | --------------    | ----------------- |
      | Period            | Current Period    |
      | TimeFrame         | YTD               |
      | Basis             | Accrual           |
      | Budget Type       | Std. Budget       |
      | Group by          | Project ID - Name |
      | Variance Type     | vs. Budget        |
      | Group by(Level 2) | Entity Type       |
      | Active Entities   | Y                 |
      | Balance Forward   | N                 |
      
    When the user selects any of the filter options in the Filter Pane
    Then the visuals in the report should update dynamically based on the selection made