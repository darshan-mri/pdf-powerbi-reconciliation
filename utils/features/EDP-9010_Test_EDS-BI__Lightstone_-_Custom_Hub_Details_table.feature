Feature: Lightstone Hub Details table
Scenario: User views the Hub details table and verifies column values in the Financial Hub Map report
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the "Financial Hub Map" report
    Then the user should be able to see the Hub details table with the following columns:
      | Columns               |
      |-----------------------|
      | Entity id-Name        |
      | Entity total area     |
      | Entity Leased area    |
      | Leased area %         |
      | Revenue               |
      | Operating Expenses    |
      | NOI                   |
      | Capital Expenditure   |
    And the following column total values should match with the keycard values:
      | Columns               | Keycards       |
      |-----------------------|----------------| 
      | Entity total area     | Leasable area  |
      | Leased area %         | Leased area    |
      | NOI                   | NOI YTD        |
      | Capital Expenditure   | NOI YTD %      |