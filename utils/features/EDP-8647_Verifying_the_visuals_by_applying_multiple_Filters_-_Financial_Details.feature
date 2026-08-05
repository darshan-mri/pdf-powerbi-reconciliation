Feature: Financial Details + Filter Interaction

  Scenario Outline: User applies filters and sees updated visuals in the report
    Given The User logs into Power BI
    And The User opens the Financial Details report from the workspace
    When The User applies the <Filter> from the filter pane
    Then The visuals in the report are updated
    And values are displayed according to the selected filter

  Examples:
    | Filters             |
    | MRI Financial Format |
    | Active Entities      |
    | Basis                |
    | Portfolio            |
    | Entity Type          |
    | Life Code            |
    | Property Type        |
    | Property Sub Type    |
    | Class ID             |
    | Investment Flag      |
    | Investment Type      |
    | Location ID          |
    | State ID             |
    | Client Name          |
    | Suite Type           |
    | Owner                |
    | Asset Manager        |
    | Department           |
    | Region               |
    | Project ID - Name    |
    | Balance Forward      |