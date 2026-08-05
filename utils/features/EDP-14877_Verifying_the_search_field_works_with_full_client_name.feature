Feature:Client Management
  
  Scenario: Verify search works with full Client Name

    Given the user logged in as Admin 
    And is in the "Client Management" page
    When the user clicks on the "Search for client" field
    Then the "Search for client" field should be highlighted
    And the cursor should be visible inside the "Search for client" field
    When the user enters a valid full "MRI Client" or "Client Name"
    Then matching Client suggestions should be displayed
    When the user selects an "MRI Client" or "Client Name" from the suggestions
    Then the user should appear in the results table with the following details:
      | Field           | Expected Value         |
      | MRI Client      | Client Id              |
      | Client Name     | Client name            |
      | Status          | Active/Defined State   |
      | Modified User   | Last Modified User     |
      | Modified Date   | Valid Date-Time Format |
      | Actions         | Edit/Delete available  |