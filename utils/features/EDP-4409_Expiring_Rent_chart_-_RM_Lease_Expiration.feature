Feature: Residential Lease Expiration - Donut Chart Interactions

  Scenario: User interacts with the Donut Chart for Lease Expiration Data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The x and y axes along with the legends should be aligned properly
    | Legends            |
    | Regional Manager   |
    And The donut chart with proper data should be loaded
    When User hovers the mouse over a section
    Then The tooltip value for the section should be displayed
    | Tooltip            |
    | Regional Manager   |
    | Lease Expiration - Expiring Rent |
    When User clicks on any of the sections from the chart
    Then The data related to the selected section should be displayed in key cards and other visuals