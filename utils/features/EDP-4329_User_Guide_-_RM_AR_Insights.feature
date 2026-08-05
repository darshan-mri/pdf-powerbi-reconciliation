Feature: Residential AR Insights

  Scenario: Verifying that the User Guide loads correctly for the report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be loaded