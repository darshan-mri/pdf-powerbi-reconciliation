Scenario: Verify AskAgora reports load in desktop view
    Given I have logged in to the AIG portal with clientID that has AskAgora menu item enabled
    When I navigate to the main dashboard
    And I click on the AskAgora menu item
    Then the reports should be loaded successfully
    And the reports should be displayed in desktop view (not in mobile portrait)