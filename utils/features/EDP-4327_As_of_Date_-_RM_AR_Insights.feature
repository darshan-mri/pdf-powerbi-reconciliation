Feature: Residential AR Insights

  Scenario: User opens report and sees the "As of" date selected by default
      Given User logs into PowerBI
      And User opens the report from the workspace
      Then User should see the "As of" date in the format "MM/YY"
      And The "As of" date should be selected by default as the current date or the most recent updated date