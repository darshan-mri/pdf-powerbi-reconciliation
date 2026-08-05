Feature: Filter Pane - Financial Details Report APAC

  Scenario: User interacts with the filter pane
    Given the user logs into PowerBI with valid credentials
    And selects the appropriate Workspace
    When the user opens the 'Financial Details' Report
    And clicks on the Show/hide filter pane icon
    Then the user should see the following filter options in the Filter Pane:
      | Filters              |
      | -------------------- |
      | Period               |
      | Reporting            |
      | Variance Type        |
      | Group by             |
      | Active Entities      |
      | Basis                |
      | Budget Type          |
      | MRI Financial Format |
      | Entity ID - Name     |
      | Entity Type          |
      | Property Type        |
      | Property Sub Type    |
      | Investment Flag      |
      | Suite Type           |
      | Asset Manager        |
      | Region               |
      | Investment Type      |
      | Life Code            |
      | Client Name          |
      | Class ID             |
      | Owner                |
      | Location ID          |
      | Department           |
      | State ID             |
      | Project ID - Name    |
      | Portfolio ID - Name  |
      | Balance Forward      |
      
    And the default values should be selected for the following filters:
      | Filters        | Default Value     |
      | -------------- | ----------------- |
      | Period         | Current Period    |
      | Variance Type  | Blended Forecast  |
      | Group by       | Entity ID - Name  |
      | Active Entities| Y                 |
      | Basis          | Accrual           |
      | Budget Type    | Std. Budget       |
      | Balance Forward | N                |
      
    When the user selects any of the filter options in the Filter Pane
    Then the visuals in the report should update dynamically based on the selection made