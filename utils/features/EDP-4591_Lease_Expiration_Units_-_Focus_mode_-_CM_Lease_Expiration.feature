Feature: Commercial Lease Expiration

  Scenario: Interact with Lease Expiration Units chart in Focus Mode
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    And the user navigates to the Lease Expiration Units chart
    And clicks on the Focus Mode button/icon for the chart
    Then the chart visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see a Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the page