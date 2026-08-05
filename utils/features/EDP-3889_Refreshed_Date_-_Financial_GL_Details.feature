Feature: Financial GL Details Report Updated Date Display Feature

  Scenario: Ensure the updated date is displayed in the correct format
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    Then User sees updated date in the following format of Period:
      | m/dd/yyyy HH:MM:SS AM/PM Timezone |