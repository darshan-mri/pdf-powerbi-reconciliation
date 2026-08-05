Feature: User Management - State Handling

  Scenario: Verify no partial data is saved on page refresh during user creation
    Given the user is in the "User Management Page"
    When the user click on the "+Add" button
    And the "Create New User" panel should be displayed
    And the user has entered partial user details
    When the user refreshes the page
    Then no partial data should be saved
    And the user should be redirected to the "User Management" page
    And the partially entered data should be cleared