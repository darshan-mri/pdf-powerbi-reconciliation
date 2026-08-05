Feature: Residential Lease Expiration - Expiring Rent Decomposition Tree Interactions

  Scenario: User interacts with the Expiring Rent decomposition tree and updates other visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The top-level data should be displayed with appropriate attributes for the Expiring Rent decomposition tree
    When The user drills down into a specific data point
    Then The visualization should display the next level of data with relevant details
    When The user drills up to a higher level
    Then The visualization should revert to the previous level with correct data
    When User hovers the mouse over a data point
    Then The tooltip value for the data point should be displayed
    When The user selects any of the data points from the decomposition tree
    Then The relevant data should be displayed in other visuals
    When The user deselects the same data point
    Then The data should be reverted back to its original state