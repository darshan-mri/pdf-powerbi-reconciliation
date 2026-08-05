Scenario: User opens the report and views the Open Receivable trends Bar chart
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should see the "Open Receivable trends" Bar chart
    And the X-axis of the "Open Receivable trends" Bar chart should be labeled as "Month & Year" with valid data
    And the Y-axis of the "Open Receivable trends" Bar chart should be labeled as "Billing, Credits, and Open charges" with valid data