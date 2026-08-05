Feature: Residential rent step - Rent Step Summary Table Interaction in Power BI

  Scenario: Verifying interaction between Rent Step Summary table and related charts
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the Rent Step Summary table should be loaded with proper data
    When User selects any of the rows in Rent Step Summary Table
    Then Corresponding data should get reflected in Rent Step by Step Range and Rent Step Count by Regional Manager Chart