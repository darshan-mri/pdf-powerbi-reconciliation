Feature: Financial Portfolio Hub

  Scenario: User interacts with a visual without seeing pre-applied filters
      Given the user logs into Power BI
      And the user selects the workspace
      When the user opens the report
      And the user clicks on any visual within the report
      Then the user should not see any pre-applied filters on the selected visual