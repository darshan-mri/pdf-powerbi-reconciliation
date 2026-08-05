Feature: Role Management

  Scenario: Verify edit role functionality

    Given the user is logged in as an Admin
    And the user is on the "Role Management" page
    And role records already exist on the page
    When the user hovers over the "Edit" icon
    Then the tooltip "Edit" should be visible
    When the user clicks on the "Edit" icon
    Then a side panel with the title "Edit Role: <Role Name>" should be displayed
    And the "Role Name" textbox should be pre-populated with the selected role name
    And the "Permission panel" should display previously selected permissions as checked
    And the unselected permissions should remain unchecked
    And the "Update" button should be enabled
    When the user updates the permissions in the "Permission panel"
    And the user clicks on the "Update" button
    Then the updated permissions should be successfully applied to the selected role
    And a success message should be displayed
    And the updated permissions should be reflected after refreshing the page