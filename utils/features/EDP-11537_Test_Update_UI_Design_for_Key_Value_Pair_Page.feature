Feature: Key Value Pair Page UI and Functionality

  Scenario: Add button opens modal drawer
    Given I am on the Key Value Pair page
    When I click the "Add" button
    Then a modal drawer should open

  Scenario: Cancel or X closes modal drawer
    Given the modal drawer is open
    When I click the "Cancel" or "X" button
    Then the modal drawer should close

  Scenario: Pagination works correctly
    Given the Key Value Pair grid has multiple pages of data
    When I navigate through pages
    Then data should update accordingly per page

  Scenario: Edit opens modal with pre-filled data
    Given I click on the "Edit" button for a query
    Then the modal drawer should open with pre-filled query data

  Scenario: Clear button clears all fields
    Given the modal drawer has data entered
    When I click the "Clear" button
    Then all the fields should be cleared

  Scenario: Save after Add redirects correctly (Fixed)
    Given I run a query using the "Add" form
    When I click "Save"
    Then I should be redirected to the Key Value Pair grid page
    And not to the homepage

  Scenario: Search functionality works (Fixed)
    Given I enter a search term in the search box
    When I type letters into the box
    Then the results should dynamically filter based on input

  Scenario: Success message appears in modal drawer (Fixed)
    Given I successfully execute a query
    Then a success message should appear inside the modal drawer

  Scenario: Buttons placement is correct (Fixed)
    Given the modal drawer is open
    Then the Update and Save buttons should appear beside the Clear and Cancel buttons based on context

  Scenario: Add after Edit shows clean form (Fixed)
    Given I click "Edit" on a query and then click "Add"
    Then the modal drawer should display an empty form

  Scenario: Update during Edit does not throw error (Fixed)
    Given I am editing a query
    When I click "Update"
    Then it should update the query without throwing an error

  Scenario: Edit after executing query does not retain previous output (Fixed)
    Given I have executed a query
    And I navigate to another query and click "Edit"
    Then the modal drawer should not retain or display previous query output