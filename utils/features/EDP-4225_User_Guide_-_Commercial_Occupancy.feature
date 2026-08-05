Feature: Commercial Occupancy

  Scenario: Load User guide in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be properly loaded as a document/PDF