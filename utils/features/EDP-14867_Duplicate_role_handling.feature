Feature:Role Management
  Scenario:Verifying the Duplicate role management
     
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
    Then the valid error message should be displayed indicating that the role already exists
    And the role should not be added in the table