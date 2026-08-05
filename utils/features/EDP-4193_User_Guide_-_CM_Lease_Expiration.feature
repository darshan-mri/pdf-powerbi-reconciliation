Feature: Commercial Lease Expiration

  Scenario: Load User guide for the report
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be loaded properly as a document/pdf