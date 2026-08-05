Feature: Query Connector Page Functionality and Validations

  Scenario: Add button opens modal drawer
    Given I am on the Query Connector page
    When I click the "Add" button
    Then the form should open in the modal drawer

  Scenario: Cancel or X closes modal drawer
    Given the modal drawer is open
    When I click the "Cancel" or "X" button
    Then the modal drawer should close

  Scenario: Sorting functionality works
    Given I am on the Query Connector grid
    When I click on a column header
    Then the data should be sorted correctly

  Scenario: Default value in Type dropdown is "Select Type" (Fixed)
    Given I open the Add Query Connector form
    Then the "Type" dropdown should have "Select Type" as the default value

  Scenario: Form validation implemented (Fixed)
    Given I open the Add Query Connector form
    When I try to save without filling required fields
    Then validation messages should appear for each required field

  Scenario: Default value in Status dropdown is "Select Status" (Fixed)
    Given I open the Add Query Connector form
    Then the "Status" dropdown should have "Select Status" as the default value

  Scenario: Clear button resets the form fields (Fixed)
    Given I have entered data into the form
    When I click the "Clear" button
    Then all fields should be reset
    And a pop-up should appear with the message "Query Cleared Successfully"

  Scenario: SQL validation in Query Editor (Fixed)
    Given I enter a query with restricted keywords (e.g., INSERT, UPDATE, DELETE, etc.)
    Then the "Execute" button should be disabled
    And an error message should be shown: "Select query is only allowed"

  Scenario: Edit works consistently (Fixed)
    Given I click on the "Edit" button for a query
    Then the modal drawer should open with pre-filled data
    And I should be able to perform Edit multiple times consistently

  Scenario: Name and Reference fields should not be identical (Fixed)
    Given I enter the same value for "Name" and "Reference"
    When I try to save the form
    Then an error message should be displayed
    And the form should not be saved