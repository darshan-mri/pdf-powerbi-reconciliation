Feature: Fix functions message queue failures

  Scenario: Deleting a report after a new draft is published in another tab
    Given I am logged into the AIG
    And I create and publish a new report

    When I open the same report in a second tab
    And I attempt to delete the report
    And I do not confirm the delete confirmation dialog

    And I switch back to the first tab
    And I create a new draft of the report
    And I publish the draft

    And I switch back to the second tab
    And I confirm the delete confirmation dialog

    Then I check App Insights for recent deletion transactions(i.e Home-->appi-aig-dev-->Search>Select property= Type Cloud name-->AIG functions)
    And I should see a message stating the report "was deleted before backup could be processed. Skipping backup."