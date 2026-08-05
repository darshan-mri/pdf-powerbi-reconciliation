Feature: Client Management

  Scenario: Verify page behavior on refresh from Client Management page

    Given the user logged in as Admin
    And the user is in the "Client Management" page
    And client records are displayed in the table
    When the user refreshes the page
    Then the page should reload successfully
    And the user should remain on the "Client Management" page
    And the client  table should display the latest data
    And no data should be lost or duplicated