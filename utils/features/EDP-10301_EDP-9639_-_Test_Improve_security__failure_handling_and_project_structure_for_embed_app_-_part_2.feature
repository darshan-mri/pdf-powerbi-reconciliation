Feature: Embedding a dashboard iframe in CodePen

  Scenario: Embed iframe in CodePen using full HTML structure
    Given I open "https://codepen.io" in Google Chrome
    When I click on "Start Coding"
    And I press Shift + ! and then Tab to generate a full HTML body
    And I insert the following iframe inside the <body> tag:
      """
      <iframe width="100%" height="500" src="https://dev-embed-Mriagorainsights.devtest.mrisoftware.com/dashboards/3f9a74b4-f7bd-4033-894a-6d036ddb603?clientid=P123456" allow="clipboard-write" width="100%" height="600px"></iframe>
      """
    Then the iframe should render the embedded dashboard correctly

  Scenario: Test error handling with invalid iframe parameters
    Given I have embedded the iframe in the HTML body on CodePen
    When I modify the "reportid" (the section following dashboards in the url), "clientid", or full "URL" with invalid values
    Then I should see appropriate error messages indicating an issue with the parameters but not displaying real report id