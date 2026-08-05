Feature: Residentials Occupancy and Rent Insights

  Scenario: Displaying the updated date in the correct format
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The updated date should be displayed in the following format: mm/dd/yyyy HH:MM:SS AM/PM Timezone