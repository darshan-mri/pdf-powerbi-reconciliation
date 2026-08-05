Feature: User Management

  Scenario: Display error when adding a user who already has access

    Given the user is on the "User Management" page

    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New User"
    When the user enters an existing email address in the "Search by email" textbox
    And selects the email from the suggestions
    Then the following user details should be auto-populated:
      | Field         | Expected Value        |
      | First Name    | Retrieved First Name  |
      | Last Name     | Retrieved Last Name   |
      | Email Address | Selected Email        |

    When the user selects a role from the "Role" dropdown
    And clicks on the "Save" button
    Then a loading indicator should be displayed
    And an error message should be displayed at the top of the panel
    And the error message should read "An error occurred. User already has access for this client"
    And the user should not be added to the User Management list
    And the side panel should remain open
    And the previously entered user details should remain unchanged
    And the "Save" button should remain enabled

    Given the error message "An error occurred. User already has access for this client" is displayed

    When the user clicks on the close (X) icon on the error message
    Then the error message should disappear
    And the user should remain on the "Create New User" panel
    And the previously entered user details should remain unchanged