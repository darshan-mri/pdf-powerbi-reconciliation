Feature: Key Value Pair Query

  Scenario: Verify search works with client id

    Given the user is on the "Key Value Pair query" page

    When the user clicks on the "Search for key value pair" field
    Then the "Search for key value pair" field should be highlighted
    And the cursor should be visible inside the "Search key value pair" field
    When the user enters a valid client id
    Then matching client id suggestions should be displayed
    When the user selects an client id from the suggestions
    Then the query should appear in the results table with the following details:
      | Field           | Expected Value         |
      | Client Name     | Name of the client     |
      | Status          | Active/Defined State   |
      | Modified User   | Last Modified User     |
      | Modified Date   | Valid Date-Time Format |
      | Actions         | Edit/Delete available  |