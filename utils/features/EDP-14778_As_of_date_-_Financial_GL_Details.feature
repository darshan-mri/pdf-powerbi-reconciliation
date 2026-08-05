Feature: Financial Hub Map + Display As Of Date

  Scenario: User sees the As of date in the correct format in the Financial Hub Map report
    Given User logs into PowerBI
    And User opens Financial Hub Map report from the workspace
    Then User sees As of date in the format:
      | mm/yy Period |