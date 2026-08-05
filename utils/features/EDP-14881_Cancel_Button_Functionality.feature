Feature: User Management

  Scenario: Cancel user creation after entering details

    Given the user logged in as Admin 
    And the user is in the "Client Management" page
    When the user clicks on the "+ Add" button
    Then a side panel should appear with the title "Create New Client"
    And a "MRI Client" and "Client Name" textboxes should be visible
    When the user focuses on the active textbox
    Then the textbox should be highlighted
    And the cursor should be visible in the textbox
    When the user enters a valid "MRI Client" and "Client Name"
    Then matching Client Suggestion should be visible
    When the user selects an Client from the suggestions
    Then the following user details should be auto-populated:
      | MRI Client     |
      | Client Name    |
      
    Then the "Save" button should be enabled
    When the user clicks on the "Cancel" button
    Then the "Create New Client" side panel should be closed
    And the user should be redirected to the "Client Management" page
    And the user should not be added to the User Management list