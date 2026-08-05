Feature:Client Management
  Scenario:Addition of the new client

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
When the user enters valid values in the following fields:
  | Field Name   | Value        |
  | MRI Client   | <valid_mri>  |
  | Client Name  | <valid_name> |

Then the "Save" button should be enabled
When the user clicks on the "Save" button
Then the new client record should be created successfully
And the record should be displayed in the list with the following columns:
  | MRI Client     |
  | Client Name    |
  | Status         |
  | Modified User  |
  | Modified Date  |
  | Actions        |