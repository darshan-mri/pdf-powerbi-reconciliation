Feature: Updated Date Visual - AH Compliance Certifications
  Scenario: Verify Updated Date Format in Report
    Given the user is logged into Power BI
    When the user has selected appropriate Workspace
    And the user Opened "AH Compliance Certifications" Report
    Then the visuals in the report should display without any breakage
    And the "Updated Date" should be displayed in the Upper right corner of the Report and to the left of user Guide icon
    Then User should see the updated date in the format: 
      | mm/dd/yyyy hh:mm:ss timezone |
    And the format of the TimeZone should be "EDT"