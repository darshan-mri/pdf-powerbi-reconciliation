Feature: Residential Occupancy - Display Updated Date 

  Scenario: User opens the report and sees the updated date in the correct format along with Residential Occupancy data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the updated date should be displayed in the following format mm/dd/yyyy
    And Residential Occupancy data should be displayed correctly in the report