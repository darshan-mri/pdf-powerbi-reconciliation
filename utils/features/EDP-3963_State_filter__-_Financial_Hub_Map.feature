Feature: Financial Hub Map + State Filter Interaction

  Scenario: Update values based on State filter selection
    Given the user is logged into PowerBI
    And the user opens the "Financial Hub Map" report from the workspace
    When the user selects a State from the filters pane
    Then the following <Key Cards> values should be updated according to the selected State:
      | Key Cards     |
      | State         |
      | Entities      |
      | Leasable Area |
      | Leased Area   |
      | NOI YTD       |
    And the "Hub Map" and "Hub Details" table should reflect the selected State filter