Feature: Card Designer - Create Card

  Scenario: Verify creation of a new card using General option

    Given the user is logged in as an "Admin"
    And the user is on the "Card Designer" page
    When the user clicks on the "+ Add" button
    Then the "Create New Card" panel should be displayed
    And the user selects the "General" option
    Then the "General" section should display the following fields:
      | Field        |
      | Name         |
      | Description  |
      | Category     |
      | Status       |
    When the user enters valid data in all the required fields
    Then the "Next" button should be enabled
    When the user clicks on the "Next" button
    Then the user should be redirected to the "Card Designing" page