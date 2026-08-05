Scenario: Refresh button clears cache and triggers new API call
  Given I have successfully logged into the plugin
  Then the "Refresh" button should be visible
  When I click on the "Refresh" button
  Then the plugin cache should be cleared
  And a new API call should be triggered
  And the latest set of keys should be fetched and displayed