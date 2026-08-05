Feature: User Management

  Scenario: Add a new user successfully

    Given the user logged in as Admin
    And is in the "User Management" page
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
    When the user clicks on the "Save" button
    Then a loading indicator should be displayed
    And the user should be successfully added to the User Management list
    Then the user should appear in the user table with the following details:
      | Field           | Expected Value              |
      | First Name      | Retrieved First Name        |
      | Last Name       | Retrieved Last Name         |
      | Email Address   | Selected Email              |
      | Role            | Selected Role               |
      | Status          | Active/Invited/Defined State|
      | Modified User   | Current Logged-in User      |
      | Modified Date   | Valid Date-Time Format      |
      | Actions         | Edit and Delete options     |