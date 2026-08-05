Feature: User Management - Page Refresh Behavior

  Scenario: Verify page behavior on refresh from User Management page

    Given the user is on the "User Management" page
    And user records are displayed in the table
    When the user refreshes the page
    Then the page should reload successfully
    And the user should remain on the "User Management" page
    And the user table should display the latest data
    And no data should be lost or duplicated