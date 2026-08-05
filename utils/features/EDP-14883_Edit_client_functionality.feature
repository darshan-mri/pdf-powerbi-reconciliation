Feature: Client Management

  Scenario: Verify admin can edit Client

    Given the user Logged in as Admin
    And the user is in the "Client Management" page
    And a client record exists in the table
    When the admin clicks on the "Edit" icon for a specific Client
    Then the "Edit " panel should be displayed
    And the existing Client details should be pre-populated
    When the admin updates the "Status" field
    And clicks on the "Save" button
    Then a loading indicator should be displayed
    And the changes should be saved successfully
    And the updated status should be reflected in the Client table
    And the "Modified User" should be updated to the current logged-in admin
    And the "Modified Date" should be updated with the latest timestamp