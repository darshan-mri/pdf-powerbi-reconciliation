Feature: CM Lease Expiration Report Last data update date icon

  Scenario: Ensure the updated date is displayed in the correct format
    Given User logs into PowerBI
    And User opens CM Lease Expiration report from the workspace
    Then User sees Last data update date icon
    And when user hoverover in it the date should display in the following format of Period:
    | mm/dd/yyyy HH:MM:SS AM/PM Timezone |