Feature: Residential AR Insights By Period

  Scenario: Viewing, Selecting, and Deselecting Records in the Open Charges Table
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then User should be able to see the Billing By source table with the proper data
    And Billing By source table should not display any "0.00" values
    When User selects a record from the Billing By source table
    Then The selected row should be highlighted
    And The other visuals should be updated according to the selected record
    When User deselects the selected row
    Then All other visual data should be reverted back to its original state