Feature: Query Connector

  Scenario: Add a new query connector successfully

    Given the user is logged in as an "Admin"
    And the user is on the "Query Connector" page
    When the user clicks on the "+ Add" button
    Then a side panel should be displayed
    And the panel title should be "New Connector"
    And the panel should contain the following fields:
      | Field Name  | Field Type |
      | Name        | Textbox    |
      | Type        | Dropdown   |
      | Description | Textbox    |
      | Query       | Textbox    |
      | Input Key   | Textbox    |
    When the user clicks inside the "Name" textbox
    Then the textbox should be highlighted
    And the cursor should be visible inside the textbox
    When the user clicks on the "Type" dropdown
    Then the dropdown options should be displayed
    And the options should include:
      | Plugin Data   |
      | Plugin Action |
    And the user should be able to select an option
    When the user clicks on the Descripton the cursor should be in the textbox
    When the user clicks on the Query textbox the cursor should be inside the textbox
    When the user clicks on the input key dropdown
    Then the dropdown option should include:
       |Occupant Name|
       | Building Name|
    When the user leaves some the fields empty
    Then Execute button should be disabled
    And clicks on the "Save" button
    Then the query connector should not be created successfully
    And the newly created connector should not be visible in the list