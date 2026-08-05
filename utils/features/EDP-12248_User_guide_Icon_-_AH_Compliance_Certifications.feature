Feature: AH Compliance Certifications - User Guide Link

  Scenario: User accesses the User Guide for the report
    Given the user is logged into Power BI
    And the user has selected the appropriate workspace
    When the user opens "AH Compliance Certifications" report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be Opened in new browser tab