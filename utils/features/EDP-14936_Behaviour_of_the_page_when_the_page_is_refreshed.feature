Feature: Key Value Pair Query 

  Scenario: Verify page behavior on refresh from Key value Pair Query page

    Given the user logged in as Admin
    And  records are displayed in the table
    When the user refreshes the page
    Then the page should reload successfully
    And the user should remain on the "Key Value Pair Query" page
    And the table should display the latest data like Active query
    And no data should be lost or duplicated