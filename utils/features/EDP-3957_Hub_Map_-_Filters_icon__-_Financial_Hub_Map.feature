Feature: Financial Hub Map + Filters Interaction

  Scenario: User hovers over the Filters icon in the Hub Map
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    When User hovers over the Filters icon in the Hub Map
    Then User should see the applied filters