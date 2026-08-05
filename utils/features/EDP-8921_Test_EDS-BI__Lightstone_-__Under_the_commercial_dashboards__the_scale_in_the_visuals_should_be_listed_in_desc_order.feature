Feature: Lightstone Open Receivables Trends Sorting Order
Scenario: User views Open Receivables Trends Stacked Column chart
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should see the data loaded properly for the "Open Receivables Trends" Stacked Column chart
    And the X axis should be labeled as "Month-Year"
    And the Y axis should be labeled as "Billings, Credits, Open Charges"
    And the X axis data should be displayed in descending order
    And the Y axis data should be displayed in ascending order