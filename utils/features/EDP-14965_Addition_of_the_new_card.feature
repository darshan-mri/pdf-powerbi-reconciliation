Feature: Card Designer

  Scenario: Addition of the new card

    Given the user is logged in as "Admin"
    And the user is on the "Card Designer" page
    When the user clicks on "+Add"
    Then the "Create New Card" panel should be displayed
    And the panel should have the options:
      | General    |
      | Background |
    And the "General" section should contain the following fields:
      | Name        |
      | Description |
      | Category    |
      | Status      |
    And the card selection options should be displayed
    And in the "Background" section the following fields must be visible:
      | Background         |
      | Background Colour  |
      | Opacity            |
    And the "Next" and "Cancel" buttons should be visible at the bottom
    And the "Next" button should be disabled