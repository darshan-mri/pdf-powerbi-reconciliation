Feature: Financial GL Details Report Loading Feature

  Scenario: Ensure report loads without breaking any visuals
    Given User logs into PowerBI
    And User selects the workspace
    When User opens Financial GL Details report
    Then the report should load without breaking any of the following visuals:
      | As Of Date                |
      | Refreshed Date            |
      | Last Updated date icon    |
      | User Guide icon           |
      | Total Amount keycard      |
      | Transaction Details table |