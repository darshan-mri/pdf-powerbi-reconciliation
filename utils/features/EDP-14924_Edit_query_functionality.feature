Feature: Key Value Pair Query

  Scenario: Verify admin can edit Query

    Given the user logged in as Admin
    And the user is in the "Key Value Pair Query"
    And a Query exists in the table
    When the admin clicks on the "Edit" icon for a specific Query
    Then the "Edit Key Value Pair" panel should be displayed
    And the existing Query should be pre-populated
    And the execute button should be enabled
    When the admin updates the Query
    And clicks on the "Execute" button
    Then a loading indicator should be displayed
    And "Sample Output Data from above Query" Should be displayed along with the Status of the Query
    And the "Update" button should be enabled
    When the user updates the changes
    And clicks on the "Update" button
    Then the changes should be saved successfully
    And the updated Query should be reflected in the user table
    And the "Modified User" should be updated to the current logged-in admin
    And the "Modified Date" should be updated with the latest timestamp
    And status of that particular query should be displayed