Feature: Reset dashboard to original state

  Scenario: Reset dashboard after bookmark is applied
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "AIGDEPLOYAPP client id"
    And I open any report[Standard]
    And I click on bookmark on top right,create a bookmark if one does not already exist
    And I click bookmark again to see the bookmark created,select apply from the dropdown
    Then the Reset button should be enabled(Which is between favourite and bookmark "left arrow")

    When I click on the Reset button
    Then I should see a confirmation message that the current bookmark changes will be cleared

    When I click OK on the confirmation dialog
    Then the dashboard should return to the default state
    And the applied bookmark should be cleared(Should still able to see the bookmark that created first)


  Scenario: Reset dashboard after adhoc changes without bookmark
    Given I am logged in to the Dev portal
    And I open any report with no bookmark applied
    When I make adhoc changes to filters or slicers
    Then the Reset button should be enabled

    When I click on the Reset button
    Then I should see a confirmation message that the changes made to filters or slicers will be removed

    When I click OK on the confirmation dialog
    Then the dashboard should return to the original default state
    And all adhoc changes should be removed