Feature: Residential Vacancy Analysis

  Scenario Outline: User views table details from key cards

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on "More Details" from the <key card>
    Then the table for the corresponding key card should be displayed with the proper table title

    Examples:
      | key card    |
      | vacant Units |
      | Vacancy %    |
      | Change %     |