Feature: Residential Vacancy Analysis

  Scenario: User opens a report without visual errors

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the report should load all the following visuals without breaking:
      | As of date                       |
      | Refreshed date                   |
      | Last data update icon            |
      | Period                           |
      | Vacant unit keycard              |
      | Vacancy % keycard                |
      | Change % Keycard                 |
      | Vacancy % By Property chart      |
      | Vacant units by Regional manager |
      | Future vacancy Analysis          |