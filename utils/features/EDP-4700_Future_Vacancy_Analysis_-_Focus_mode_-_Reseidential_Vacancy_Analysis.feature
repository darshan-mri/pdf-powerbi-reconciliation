Feature: Reseidential Vacancy Analysis

  Scenario: User interacts with a table visual in Focus Mode

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the Focus Mode button/icon for the table
    Then the table visual should expand to fill the screen
    And the column headers and rows should be clearly visible
    And other page elements should be hidden
    And the user should see the "Back to report" button

    When the user clicks on the "Back to report" button
    Then it should navigate back to the page