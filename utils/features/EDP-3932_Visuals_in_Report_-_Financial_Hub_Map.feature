Feature: Financial Hub Map + Report Visual Integrity

  Scenario: User opens Financial Hub Map report and sees no broken visuals
    Given User logs into PowerBI
    And User selects the workspace
    When User opens Financial Hub Map report
    Then The report should load without breaking any of the following visuals:
      | As Of Date            |
      | Refreshed Date        |
      | Last Updated date icon|
      | User Guide icon       |
      | State keycard         |
      | Entities keycard      |
      | Leasable Area keycard |
      | Leased Area keycard   |
      | NOI YTD keycard       |
      | Hub Map               |
      | Hub Details table     |