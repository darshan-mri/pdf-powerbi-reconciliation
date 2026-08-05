Feature: Financial Hub Map + Display Updated Date

  Scenario: User sees the updated date in the correct format in the Financial Hub Map report
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    Then User sees Updated date in the following format:
      | m/dd/yyyy HH:MM:SS AM/PM Timezone |