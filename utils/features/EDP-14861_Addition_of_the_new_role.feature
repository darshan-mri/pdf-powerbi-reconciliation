Feature: Role Management

  Scenario: Add a new role successfully

    Given the user logged in as Admin
    And is in the "Role Management" page
    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New Role"
    And a "Role Name" textbox should be visible
    And a "Permissions" section should be visible
    When the user focuses on the "Role Name" textbox
    Then the textbox should be highlighted
    And the cursor should be visible in the textbox
    When the user enters a valid role name
    Then the user selects permissions from the "Permissions" section
    And the selected permissions should be highlighted/marked
    When the user selects permissions from the "Permissions" section
    And the user has entered a valid role name
    Then the "Save" button should be enabled
    When the user clicks on the "Save" button
    Then a loading indicator should be displayed
    And the role should be successfully added to the Role Management list

    Then the new role should appear in the role table with the following details:
      | Field           | Expected Value              |
      | Role Name       | Entered Role Name          |
      | Permissions     | Selected Permissions       |
      | Modified User   | Current Logged-in User     |
      | Modified Date   | Valid Date-Time Format     |
      | Actions         | Edit and Delete options    |