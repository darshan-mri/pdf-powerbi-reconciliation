Feature: Average Days to Complete - AH Annual Certifications

  Scenario: User interacts with "Average Days to Complete" KeyCard
    Given the user is logged into Power BI
    When the user selects the appropriate workspace
    And the user opens the "AH Annual Certifications" Report
    Then the visuals in the report should load without any visual breakage
    And by default, the title of the KeyCard should be "Average Days to Complete - Last 12m"
    And the "Average Days to Complete" KeyCard should display the following month details:
      | Last 12 Months |
      | Last 3 Months  |
      | Last 6 Months  |
    Then the "Last 12 Months" KeyCard visual should be formatted as callout values in Visualizations pane
    And the "Last 3 Months" and "Last 6 Months" keyCard visual should be formatted as reference labels in Visualizations pane
    And if any values are blank, they should be represented as '--'