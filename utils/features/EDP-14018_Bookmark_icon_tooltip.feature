Scenario: Verify bookmark icon and tooltip behavior for applied, non-applied, create, rename, delete, update and edge cases
  Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as "AIGDEPLOYAPP client id"
  And I open any report

  # Initial load - no bookmark applied
  Then the bookmark button tooltip should display "Bookmarks"
  And the bookmark icon should be displayed as outline

  # Initial load - default bookmark applied
  Given the report has a default bookmark configured
  When the report reloads
  Then the bookmark button tooltip should display the default bookmark name
  And the bookmark icon should be displayed as filled

  # Apply an existing bookmark
  When I open the bookmark menu
  And I apply the bookmark named "Q1 Sales"(if not create one with anyname)
  Then the bookmark button tooltip should display "Q1 Sales"
  And the bookmark icon should be displayed as filled

  # Create a new bookmark
  When I create a new bookmark named "My View"
  Then the bookmark button tooltip should display "My View"
  And the bookmark icon should be displayed as filled
  And a success notification should be displayed

  # Rename currently applied bookmark
  When I rename the bookmark "My View" to "First Quarter Sales"
  Then the bookmark button tooltip should display "First Quarter Sales"
  And the bookmark icon should be displayed as filled
  And a success notification should be displayed

  # Rename non-applied bookmark
  Given another bookmark named "Q2 Sales" exists
  When I rename the bookmark "Q2 Sales" to "Second Quarter"
  Then the bookmark button tooltip should still display "First Quarter Sales"
  And the bookmark icon should be displayed as filled

  # Update currently applied bookmark
  When I modify the report state
  And I update the bookmark "First Quarter Sales"
  Then the bookmark button tooltip should display "First Quarter Sales"
  And the bookmark icon should be displayed as filled
  And a success notification should be displayed

  # Update non-applied bookmark
  Given another bookmark named "New Dashboard View" exists
  When I update the bookmark "New Dashboard View"
  Then the bookmark button tooltip should display "New Dashboard View"
  And the bookmark icon should be displayed as filled
  And a success notification should be displayed

  # Delete non-applied bookmark
  When I delete the bookmark "Second Quarter"
  Then the bookmark button tooltip should still display "First Quarter Sales"
  And the bookmark icon should be displayed as filled

  # Delete currently applied bookmark
  When I delete the bookmark "First Quarter Sales"
  Then the bookmark button tooltip should display "Bookmarks"
  And the bookmark icon should be displayed as outline
  And a success notification should be displayed

  # Long bookmark name
  When I create and apply a bookmark with a name longer than 50 characters
  And I hover over the bookmark button
  Then the tooltip should display the full bookmark name without truncation

  # Special characters in bookmark name
  When I create and apply a bookmark with special characters including quotes and ampersands
  And I hover over the bookmark button
  Then the tooltip should display special characters correctly without HTML encoding issues

  # Cross-browser tooltip validation
  When I hover over the bookmark button
  Then the tooltip should be visible and correctly formatted across supported browsers