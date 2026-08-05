Feature:Client Management

  Scenario: Verify items per page dropdown updates records, persists across navigation, and handles limited data

    Given the user logged in as Admin
    And the user is in the "Client Management" page
    And multiple Client records exist
    When the user clicks on the "Items per page" dropdown
    Then the dropdown options should be displayed
    When the user selects "10" from the dropdown
    Then the user table should display up to 10 records per page
    And the pagination should be updated accordingly
    And the current page should reset to the first page
    When the user navigates to another page
    Then the selected items per page value should remain as "10"
    And the Client table should continue to display up to 10 records per page
    Given the total number of records is less than 10
    Then all available records should be displayed
    And no empty rows should be shown