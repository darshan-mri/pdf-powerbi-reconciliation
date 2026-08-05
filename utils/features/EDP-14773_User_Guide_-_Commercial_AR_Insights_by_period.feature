Feature: Commercial AR Insights by period - User Guide Link

  Scenario: User accesses the User Guide for the report
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be loaded