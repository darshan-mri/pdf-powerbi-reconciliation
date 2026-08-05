Feature: Client Management

  Scenario: Verify no partial data is saved on page refresh during user creation
    
    Given the user logged in as Admin
    And the user is in the "Client Management" Page
    When the user click on the "+Add" button
    And the "Create New Client" panel should be displayed
    And the user has entered partial client details
    When the user refreshes the page
    Then no partial data should be saved
    And the user should be redirected to the "Client Management" page
    And the partially entered data should be cleared