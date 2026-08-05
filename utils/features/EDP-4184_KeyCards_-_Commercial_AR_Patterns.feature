Feature: Commercial AR Patterns

  Scenario: Display specific visuals with proper data
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then the following visuals should be displayed with proper data:
      | Total Open Charges |
      | Billings           |
      | Credits/Payments   |
      | Open Charges       |