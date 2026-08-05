Feature: Residential Rent Step

  Scenario: Verifying the Residential Rent column in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to a page with a table visual
    Then the Residential Rent column should display the correct rent values for all entries