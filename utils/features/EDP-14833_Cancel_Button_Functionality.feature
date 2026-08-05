Feature: User Management

  Scenario: Cancel user creation after entering details

    Given the user is on the "User Management" page

    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New User"
    And a "Search by email" textbox should be visible
    When the user focuses on the "Search by email" textbox
    Then the textbox should be highlighted
    And the cursor should be visible in the textbox
    When the user enters a valid email address
    Then matching email suggestions should be displayed
    When the user selects an email from the suggestions
    Then the following user details should be auto-populated:
      | Field          | Expected Value       |
      | First Name     | Retrieved First Name |
      | Last Name      | Retrieved Last Name  |
      | Email Address  | Selected Email       |
      | Role           | Dropdown is visible  |
    When the user selects a role from the "Role" dropdown
    Then the "Save" button should be enabled
    When the user clicks on the "Cancel" button
    Then the "Create New User" side panel should be closed
    And the user should be redirected to the "User Management" page
    And the user should not be added to the User Management list