Feature: B&F Financial NOI Analysis

  Scenario: Verify report visuals load correctly
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the Financial NOI Analysis report
    Then the report should load without breaking any of the following visuals:
      | Revenue YTD keycard with budget and variance details                       |
      | Operating Exps YTD keycard with budget and variance details                |
      | NOI YTD keycard with budget and variance details                           |
      | NOI by Entity YTD (Actuals vs. Budget) line clustered chart                |
      | YTD Revenue (Actuals vs. Budget) Total revenue line chart                  |
      | YTD Revenue (Actuals vs. Budget) Other Income line chart                   |
      | YTD Revenue (Actuals vs. Budget) Rent line chart                           |
      | YTD Revenue (Actuals vs. Budget) Recoverable income line chart             |
      | Operating Expenses Actual (Actuals vs. Budget) Non-recoverable Opex line   |
      | Operating Expenses Actual (Actuals vs. Budget) Recoverable Opex line chart |
      | Operating Expenses Actual (Actuals vs. Budget) Total Opex line chart       |
      | NOI Variance Breakdown table                                               |
      | Ask Agora                                                                  |