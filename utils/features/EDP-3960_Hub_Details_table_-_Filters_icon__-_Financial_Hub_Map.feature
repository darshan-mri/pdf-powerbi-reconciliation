Feature: Financial Hub Map + Filters Icon Hover Interaction

  Scenario: User hovers over the Filters icon in the Hub Details table
    Given User logs into PowerBI
    And User opens the Financial Hub Map report from the workspace
    When User hovers over the Filters icon in the Hub Details table
    Then User should see the applied filters