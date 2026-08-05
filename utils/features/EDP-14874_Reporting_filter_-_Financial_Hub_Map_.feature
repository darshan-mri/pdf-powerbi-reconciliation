Feature: Reporting Options Filter - Financial Hub Map

Scenario: Validate reporting option filter of financial details report
Given the user logs into Power BI
And selects the workspace
And opens Financial Hub Map Report
When user opens the filter pane
Then the Reporting filter should be present with "Current" option selected by default

When the user selects the "Current" option in the "Reporting Options" filter
Then the report should reference the MRI FinancialEntitiesPeriod table
And the report should display data for the current period of the selected entity

When the user selects the "Last Closed" option in the "Reporting Options" filter
Then the report should reference the MRI FinancialEntitiesPeriod table
And the report should display data for the last closed period of the selected entity

When the user selects the "Custom Period" option in the "Reporting Options" filter
And the user selects a specific reporting period
Then the report should display data for the selected reporting period

When the user selects the "Alternative Year End Period" option in the "Reporting Options" filter
And the user selects a reporting period
Then the report should display data for the 12 months prior to the selected reporting period