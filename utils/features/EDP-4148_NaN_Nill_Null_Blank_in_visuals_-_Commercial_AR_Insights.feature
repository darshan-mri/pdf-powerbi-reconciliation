Feature: Commercial AR Insights - NaN/Null/Nil values

  Scenario: User loads a report in Power BI without displaying invalid values
    Given the user is logged into Power BI
    And the user selects the appropriate workspace
    When the user opens the Commercial AR Insights report
    Then the report should load without breaking any visuals
    And NaN/Null/Nil/Blank values should not be displayed in any of the visuals