Feature: User interaction with Filters in the Financial Portfolio Hub Report

  Scenario Outline: User applies filters and updates visuals accordingly in the Financial Portfolio Hub report
    Given The User logs into Power BI
    And The User opens the Financial Portfolio Hub report from the workspace
    When The User applies the <Filters> from the filter pane
    Then The visuals in the report are updated, and values are displayed according to the selected filter

    Examples:
      | Filters               |
      | Exchange Rate         |
      | Period                |
      | Group By              |
      | Group By (Level 2)    |
      | Timeframe             |
      | Budget Type           |
      | MRI Financial Format  |
      | Ledger Code           |
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
      | Balance Forward       |