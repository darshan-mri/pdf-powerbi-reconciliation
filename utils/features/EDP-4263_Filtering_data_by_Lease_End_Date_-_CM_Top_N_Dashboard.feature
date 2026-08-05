Feature: Commercial Top N
Scenario: User filters data using lower and upper limits for Lease End Date
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User inputs a lower limit and an upper limit in the Lease End Date section
    Then the following visuals should limit the data based on the given input:
      | Lease Expiration                         |
      | Top N Details                            |
      | Top N by Occupant                        |
      | Total Sq. Ft. and Rent PSF Scatter Chart |