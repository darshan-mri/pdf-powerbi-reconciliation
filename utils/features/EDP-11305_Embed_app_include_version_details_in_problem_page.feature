Background:
    Given I have access to the embedded app at "https://dev-embed-mriagorainsights.devtest.mrisoftware.com/workspacesss/pmx/dashboards/Commercial%20Occupancy?clientid=MRIQWEB&authMode=tab"

  Scenario: View trace details and copy on Page Not Found in standalone embed
    When I wait for the embedded report to load successfully
    And I modify the URL to an invalid one (e.g., append "/invalid-path") to navigate to a Page Not Found
    Then I should see the message "Sorry, we couldn't find that page."
    When I click on "View Details"
    Then I should see the "Trace Id" and "Client Version" displayed along with a "Copy" button
    When I click on the "Copy" button
    And I paste the copied content into a notepad or text editor
    Then the pasted content should include:
      """
      Message: Sorry, we couldn't find that page.
      Trace Id: <some-trace-id>
      Client Version: <some-version-number>
      """

  Scenario: View trace details and copy on Page Not Found in iframe (CodePen)
    Given I embed the same report in a CodePen iframe with `allow="clipboard-write"` enabled
      #
      <iframe width="100%" height="500" src="https://dev-embed-mriagorainsights.devtest.mrisoftware.com/workspacesss/pmx/dashboards/Commercial%20Occupancy?clientid=MRIQWEB&authMode=tab" width="100%" height="600px" allow="clipboard-write"></iframe>
      #
    And I wait for the embedded report to load inside the iframe
    When I modify the iframe URL to an invalid one (e.g., append "/invalid-path")
    Then I should see the message "Sorry, we couldn't find that page." inside the iframe
    When I click on "View Details" inside the iframe
    Then I should see the "Trace Id" and "Client Version" along with a "Copy" button
    When I click on the "Copy" button inside the iframe
    And I paste the copied content into a notepad or browser text field
    Then the pasted content should contain:
      """
      Message: Sorry, we couldn't find that page.
      Trace Id: <some-trace-id>
      Client Version: <some-version-number>
      """