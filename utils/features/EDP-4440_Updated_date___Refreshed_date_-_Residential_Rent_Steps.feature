Feature:Residential Rent step - Display of Updated Date in Power BI Report

  Scenario: Verifying the display format of the updated date in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the updated date should be displayed in the following format: mm/dd/yyyy HH:MM:SS AM/PM Timezone