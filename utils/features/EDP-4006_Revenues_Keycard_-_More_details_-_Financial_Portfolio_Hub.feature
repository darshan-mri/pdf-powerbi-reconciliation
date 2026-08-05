Feature: Financial Portfolio Hub

  Scenario: Verify visuals after clicking "More Details" from Revenues keycard
    Given User logs into PowerBI
    When User opens Financial Portfolio Hub report from the workspace
    And User opens More Details from Revenues keycard
    Then User should see the following visuals:
      | Revenue line stacked column combo chart |
      | Revenue table                           |
      | Revenue Variance scatter chart          |