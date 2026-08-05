Feature: Commercial Stacking Plan

  Scenario Outline: User views bar graph for key cards
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the user should be able to see Stacking plan - Occupied area visual
    When user clicks on More Details from the <Key Card>
    Then the <Bar Graph> and <Stacking Table> for the corresponding key card should be displayed

    Examples:
      | Key Card       | Bar Graph                  | Stacking Table                  |
      | Total Units    | Stacking Plan equal spacing| Stacking Table                  |
      | Vacant Unit    | Vacant Unit                | Stacking Table - Vacancy        |
      | Year 1 Units   | Year 1 Units               | Stacking Table - Year 1 Expiry  |
      | Year 2 Units   | Year 2 Units               | Stacking Table - Year 2 Expiry  |
      | Year 3 Units   | Year 3 Units               | Stacking Table - Year 3 Expiry  |
      | Year 4+ Units  | Year 4+ Units              | Stacking Table - Year 4+ Expiry |
      | Holdover / MTM | Holdover / MTM             | Stacking Table - Holdover / MTM |