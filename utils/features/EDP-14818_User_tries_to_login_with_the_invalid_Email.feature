Feature: Login Functionality

  Scenario: Display error when logging in with an invalid email address

    Given the user is on the "Login" page

    When the user enters an invalid email address in the "Email" field
    And the user clicks on the "Login" button
    Then a validation error message should be displayed for the "Email" field
    And the error message should read "Please enter a valid email address"
    And the user should not be logged in
    And the user should remain on the "Login" page
    And the "Email" field should be highlighted