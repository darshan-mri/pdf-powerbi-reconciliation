Feature: Card Designer - Mandatory Field Validation

  Scenario: Verify card cannot be created without filling mandatory fields
   
    Given the user is logged in as an "Admin"
    And the user is on the "Card Designer" page
    When the user clicks on the "+ Add" button
    Then the "Create New Card" panel should be displayed
    And the following fields are marked as mandatory:
      | Field |
      | Name  |
    When the user leaves all mandatory fields empty
    And clicks on the "Next" button
    Then validation error messages should be displayed for mandatory fields
    And the user should not be allowed to proceed
    And the "Next" button should remain disabled or inactive