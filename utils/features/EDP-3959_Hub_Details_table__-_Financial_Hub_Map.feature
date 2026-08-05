Feature: Financial Hub Map + Hub Details Table Interaction

  Scenario: User interacts with Hub Details Table in Financial Hub Map Report
    Given User logs into Power BI
    And User opens the Financial Hub Map report from the workspace
    Then User should see the Hub Details table with the proper data loaded for all columns with total values
      | Column Names          |
      | Entity ID - Name      |
      | Entity Total Area     |
      | Entity Leased Area    |
      | Leased Area%          |
      | Revenue               |
      | Operating Expenses    |
      | NOI                   |
      | Capital Expenditures  |
    When User clicks on any column in the Hub Details table
    Then The values in the table should be sorted accordingly by that column
    When User selects a row in the Hub Details table
    Then The visuals and values in the Hub Map and Keycards should update based on the selected row
    And The opacity of unselected rows should be reduced