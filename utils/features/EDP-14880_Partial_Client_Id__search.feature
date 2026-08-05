Feature: Client Management

  Scenario: Verify behavior when searching with partial Client Id

    Given the user logged in as Admin
    And the user is in the "Client Management page"
    When the user clicks on the "Search for Client" field
    And enters a partial Client Id or Client Name
    Then matching "Client Id or Client name" suggestions should be displayed
    And the suggestions should contain relevant users
    When the user selects a suggestion
    Then the user table should display matching Client records
    And the displayed results should match the selected email