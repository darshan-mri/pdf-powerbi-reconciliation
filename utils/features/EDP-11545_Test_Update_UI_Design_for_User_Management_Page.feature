Feature: User Management Page - Functional and UI Validations

  Scenario: Add button opens modal drawer
    Given I am on the User Management page
    When I click the "Add" button
    Then the user form should open inside a modal drawer

  Scenario: Cancel or X button closes modal drawer
    Given the modal drawer is open
    When I click the "Cancel" or "X" button
    Then the modal drawer should close

  Scenario: Add a new user successfully
    Given I open the Add User form
    When I enter valid user details and click "Save"
    Then the user should be added successfully
    And a success message should be displayed

  Scenario: Pagination functionality
    Given the User Management grid has multiple pages of data
    When I navigate to the next or previous page
    Then the user list should update accordingly

  Scenario: Sorting works for all sortable columns
    Given I am on the User Management grid
    When I click on the column headers "First Name", "Last Name", "Role", "Status", "Modified By", or "Modified Date"
    Then the data should be sorted correctly based on the selected column

  Scenario: Search functionality works for all searchable fields
    Given I type a search query into the search box
    When I search by "First Name", "Last Name", "Role", "Modified By", "Status", or "Modified Date"
    Then the grid should dynamically filter and display matching results

  Scenario: Edit loads prefilled user data
    Given I click on the "Edit" button for a user
    Then the modal drawer should open
    And the form should be prefilled with the selected user's data
    
 Scenario: Adding a user with an existing email address (Error)
    Given I try to add a user using an email address that already exists
    When I click "Save"
    Then the system should show an error message: "Email already exists"
    And the user should not be added