Feature: Filter Pane - Financial Hub Map

  Scenario: User interacts with the filter pane
    Given the user logs into PowerBI with valid credentials
    And selects the appropriate Workspace
    When the user opens the 'Financial Hub Map' Report
    And clicks on the Show/hide filter pane icon
    Then the user should see the following filter options in the Filter Pane:
      | Filters               |
      |-----------------------|
      | Period                |
      | Reporting             |
      | Active Entities       |
      | Basis                 |
      | MRI Financial Formats |
      | State                 |
      | Entity ID - Name      |
      | Project ID - Name     |
      | Portfolio ID - Name   |
      | Entity Type           |
      | Area Type             |
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
      | Balance Forward       |
    
    And the default values should be selected for the following filters:
      | Filters        | Default Value     |
      | -------------- | ----------------- |
      | Period         | Current Period    |
      | Active Entities| Y                 |
      | Basis          | Accrual           |
      | Balance Forward| N                 |
    
    When the user selects any of the filter options in the Filter Pane
    Then the visuals in the report should update dynamically based on the selection made