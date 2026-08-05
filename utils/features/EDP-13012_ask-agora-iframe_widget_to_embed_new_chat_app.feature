Background:
  Given the user is logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/onboard-config" with clientID "P123456"

Scenario: Verify Ask Agora chatbox appears after successful Okta authentication
  When the user clicks on the "Ask Agora" menu item
  And the user selects any Ask Agora report
  And the user clicks on the report display name
  Then an authentication prompt should appear on the right side
  When the user authenticates using their Okta SaaS account
  Then the page should automatically reload
  And the Ask Agora chatbox should appear on the right side of the dashboard
  And the chatbox header should display "askagora"
  And the subheader should display:
    """
    Data source User Guides: Get relevant answers, insights, and assistance based on the PMX Commercial Management user guides.
    """
  And the chatbox should show multiple pre-defined questions like:
    | question_text                                                   |
    | How do I set up automated payment application rules?            |
    | What's the process for handling CPI billing increases?          |
    | How do I configure expense recovery pools and formulas?         |
  And the input box placeholder should be "Ask a question here..."
  And a microphone icon should be visible beside the input box