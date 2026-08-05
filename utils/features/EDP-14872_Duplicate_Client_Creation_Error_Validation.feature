Feature:Client Management
  Scenario:Duplicate Client creation

    Given the user is logged in as an Admin
    And the user is on the "Client Management" page
    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New Client"
    And the following fields should be visible:
       | Field Name   |
       | MRI Client   |
       | Client Name  |

    When the user focuses on the "MRI Client" and "Client Name" fields
    Then the fields should be highlighted
    And the cursor should be visible in the active field
    When the user enters the "MRI Client" and "Client Name" already present
    And click on the "save" button
    Then a valid error message should be displayed indicating the "user already exists"
    And the field should be populated with the entered data