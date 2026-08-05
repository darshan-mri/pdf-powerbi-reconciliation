Feature: Client Management 

  Scenario: Verify behavior when searching with leading and trailing spaces in Client name or client Id

    Given the user logged in as Admin
    And the user in the "Client Management" page
    When the user clicks on the "Search for Client" field
    And enters the "Client name or Client Id" with leading and trailing spaces
    Then the system should trim the spaces
    And matching Client suggestions should be displayed
    When the user selects a suggestion
    Then the Client table should display matching Client records
    And the displayed results should match the trimmed Client name or Client email