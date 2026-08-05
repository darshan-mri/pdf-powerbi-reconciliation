Scenario: Verify +/- icons persist when switching between Users and Groups tabs in Dashboard Access
  Given I have logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/onboard-config" with clientID "AIGDEPLOYAPP"
  And I navigate to Dashboard Access
  And I am on the Groups and Users navigation page
  Then the +/- icons should be visible for Groups on initial load

  When I switch to the Users tab
  And I apply one or more filters on the Users tab
  And I save the applied filters
  And I switch back to the Groups tab
  Then the +/- icons should still be visible for Groups