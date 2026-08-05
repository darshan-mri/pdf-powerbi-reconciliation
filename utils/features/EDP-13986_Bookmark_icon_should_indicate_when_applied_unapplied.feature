Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "MRITEST client id"(Can use any client id)
    And I open any report
    When I apply filters on the report(Just make some changes to the report different from original to verify this feature)
    And I click on the bookmark icon
    And I click on "Add Bookmark"
    And I enter a unique bookmark name
    And I click on "Create", the bookmark now is applied
    And the bookmark icon should change outline to filled(i.e black)
    And I refresh the page
    Then the report should load to default report(i.e Orignal report)
    And the bookmark icon should appear outlined icon without filled(i.e bookmark border)