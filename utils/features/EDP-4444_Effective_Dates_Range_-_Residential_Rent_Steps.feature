Feature: Residential Rent Step - Effective Dates Range Selection and Data Limiting in Power BI

  Scenario: Verifying data limitation based on selected Effective Dates range
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the Effective Dates' lower and upper limit should be editable/selectable
    When the User inputs the lower and upper limit
    Then the records in all the visuals should get limited based on the range entered