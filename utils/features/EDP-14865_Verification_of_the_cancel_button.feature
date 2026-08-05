Feature: Role Management

  Scenario: Verify the functionality of the Cancel button while creating a new role

    Given the user is logged in as an Admin
    And the user is on the "Role Management" page
    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New Role"
    And a "Role Name" textbox should be visible
    And a "Permissions" section should be visible
    When the user focuses on the "Role Name" textbox
    Then the textbox should be highlighted
    And the cursor should be visible in the textbox
    When the user enters a valid role name
    And the user selects permissions from the "Permissions" section
    Then the selected permissions should be highlighted
    When the user clicks on the "Cancel" button
    Then the side panel should be closed
    And no new role should be created
    And no existing records should be modified