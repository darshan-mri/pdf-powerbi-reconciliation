Feature: Commercial Top N
Scenario: User filters data using numeric input for Top (N)
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User inputs a numeric value in the Top (N) section
    Then the following visuals should limit the data based on the given input:
      | Top N Details                           |
      | Top N by Master Occupant                |
      | Total Sq. Ft. and Rent PSF Scatter Chart |