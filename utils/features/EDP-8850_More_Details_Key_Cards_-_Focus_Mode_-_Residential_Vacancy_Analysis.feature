Feature: Residential Vacancy Analysis

  Scenario: User expands visual to Focus Mode
    Given the user is logged into Power BI
    And the user selects a workspace
    When the user opens a report
    And clicks on "More Details" from a <Key Card>
    Then the user should be able to see the coresponding <Table> for each <key vard>
    When user clicks on the "Focus Mode" button/icon for any <Table> in the chart
    Then the visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the "Back to report" button
    When the user clicks on the "Back to report" button
    Then it should navigate back to the page

    Examples:
    | Key Card       | Table              |
    | Vacancy Units  | Vacancy Unit Table |
    | Vacancy %      | Vacancy Table      |
    | Change %       | Change % Table     |