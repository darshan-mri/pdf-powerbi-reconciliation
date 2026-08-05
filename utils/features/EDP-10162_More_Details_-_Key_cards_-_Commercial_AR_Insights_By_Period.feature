Feature: Commercial AR Insights by Period - More Details Keycards

  Scenario Outline: User Click on More details option in keycards
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the User should be able to see the "<Key Cards>" along with the "More option" button
    And by default the "Open Receivables Trends" table should be displayed
    When user clicks on "More Details" from the "<Key Cards>"
    Then the user should be able to see the "<Table>" corresponding to the keycard
    And the values in the "<Table>" should match with the keycard values
    When user clicks on the "back arrow" button
    Then the user should see the "Open Receivables Trends" table
    When user clicks on the "See All Transactions" button
    Then the user should be able to see the "All Transactions" table
    When user clicks on the "back arrow" button
    Then the user should see the "Open Receivables Trends" table
    
    Examples:
    | Key Cards            | Table                                      |
    | Total Open Charges   | Total Open Charges Details                 |
    | Total Billings       | Billings Details                           |
    | Total Credits        | Credits Details                            |
    | 1st Month            | 1st Month Open charges Details             |
    | 2nd Month            | 2nd Month Open charges  Details            |
    | 3rd Month            | 3rd Month Open charges  Details            |
    | 4+ Month             | 4+ Month Open charges  Details             |