Feature: Commercial Top N

  Scenario: Accessing the User guide
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be loaded properly in PDF/Documentation