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
When the user enter the invalid "MriClient" and "Client Name"
When clicked on the "Save" button
Then the valid error message should be displayed 
And both the textboxes should be populated with the data entered