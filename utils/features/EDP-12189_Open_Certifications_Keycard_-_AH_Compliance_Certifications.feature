Feature: Open Certifications - AH Compliance Certifications

  Scenario: User interacts with "Open Certifications" KeyCard
    Given the user is logged into Power BI
    When the user selects the appropriate workspace
    And the user opens the "AH Compliance Certifications" Report
    Then the visuals in the report should load without any visual breakage
    And by default, the title of the KeyCard should be "Open Certifications"
    And the "Open Certifications" KeyCard should display the following values:
      | Open Certifications                       |
      | Open Certifications Older Than 10 Days    |
      | Average Days to Complete - Last 12 Months |
    Then the "Open Certifications" KeyCard visual should be formatted as callout values in Visualizations pane
    And the "Open Certifications Older Than 10 Days" and "Average Days to Complete - Last 12 Months" keyCard visual should be formatted as reference labels in Visualizations pane
    And if any values are blank, they should be represented as '--'