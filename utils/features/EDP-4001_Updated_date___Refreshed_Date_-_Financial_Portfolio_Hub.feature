Feature: Financial Portfolio Hub

  Scenario: Verify updated date format in Financial Portfolio Hub report
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    Then User sees Updated date in the following format:
      | m/dd/yyyy HH:MM:SS AM/PM Timezone |