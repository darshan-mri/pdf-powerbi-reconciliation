Feature: Commercial Top N
Scenario: User filters data using lower and upper limits for Total Square Foot
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User enters a lower limit and an upper limit in the Total Square Foot section
    Then the following visuals should limit the data based on the given input:
      | Top N Details             |
      | Top N by Occupant         |
      | Total Sq. Ft. and Rent PSF Scatter Chart |