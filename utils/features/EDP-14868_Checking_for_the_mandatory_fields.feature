Feature:Role Management
  Scenario: Verifying the behaviour of the page without filling the madatorry fields
     
  Given the user logged in as Admin
    And is in the "Role Management" page
    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New Role"
    And a "Role Name" textbox should be visible
    And a "Permissions" section should be visible
    When the user focuses on the "Role Name" textbox
    Then the textbox should be highlighted
    And the cursor should be visible in the textbox
    Then the user selects permissions from the "Permissions" section
    And the selected permissions should be highlighted/marked
    And the "Save button" should be still disable
    When the user tries to click on the disabled save button then the error message should be displayed displ