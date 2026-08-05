Feature: Updated Date Visual - AH Annual Certifications
  Scenario: Verify Updated Date Format in Report
    Given the user is logged into Power BI
    When the user has selected appropriate Workspace
    And the user Opened "AH Annual Certifications" Report
    Then the visuals in the report should display without any breakage
    And the "Updated Date" should be displayed in the Upper right corner of the Report and to the left of user Guide icon
    Then User should see the updated date in the format: 
      | m/dd/yyyy hh:mm:ss timezone |
    And the format of the TimeZone should be "EDT"