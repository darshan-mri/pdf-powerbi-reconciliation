Feature: Residential rent step - Rent Step Interaction and Data Verification in Power BI

  Scenario: Verifying Rent Step Details table and its interaction with other visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the Rent Step Details table should be loaded with proper data
    And all the data should be in Expanded hierarchy form
    When user selects any propertyName-ID, Building Name-ID, UnitID in Rent Step Summary table
    Then it should reflect in Rent Step Count by Regional Manager and Rent Step by Step Range Chart