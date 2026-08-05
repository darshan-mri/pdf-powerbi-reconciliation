Feature: Financial GL Details Report Filter Functionality Feature

  Scenario Outline: Ensure the visuals are updated and the applied filter is displayed in the tooltip
    Given The User logs into Power BI
    And The User opens the Financial GL Details report from the workspace
    When The User applies the <Filters> from the filter pane
    Then The visuals in the report are updated, and values are displayed according to the selected filter
    When The User hovers over the Filters icon in the Transaction Details table
    Then The User should see a tooltip displaying the applied filters

  Examples:
    | Filters               |
    | Periods               |
    | Exchange Rate         |
    | MRI Financial Format  |
    | Active Entities       |
    | Basis                 |
    | Portfolio             |
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
    | Project ID - Name     |
    | Balance Forward       |
    | Entity ID - Name      |