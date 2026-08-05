Feature: User Management - Search Functionality

  Scenario: Verify search works with full email address

    Given the user is on the "User Management" page

    When the user clicks on the "Search for User" field
    Then the "Search for User" field should be highlighted
    And the cursor should be visible inside the "Search for User" field
    When the user enters a valid full email address
    Then matching email suggestions should be displayed
    When the user selects an email from the suggestions
    Then the user should appear in the results table with the following details:
      | Field           | Expected Value         |
      | First Name      | Retrieved First Name   |
      | Last Name       | Retrieved Last Name    |
      | Email Address   | Entered Email          |
      | Role            | Assigned Role          |
      | Status          | Active/Defined State   |
      | Modified User   | Last Modified User     |
      | Modified Date   | Valid Date-Time Format |
      | Actions         | Edit/Delete available  |