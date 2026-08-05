Feature: Financial Details + Updated Date Verification

  Scenario: User sees the updated date in the correct format
    Given User logs into PowerBI
    And User opens Financial Details report from the workspace
    Then User sees updated date in the following format
      | m/dd/yyyy HH:MM:SS AM/PM Timezone |