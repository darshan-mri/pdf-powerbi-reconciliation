Feature: Commercial Top N
Scenario: User selects a grouping option and sees the updated visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the user should see the Top (N) Grouping visual with the following options:
      | Occupant         |
      | Master Occupant  |
      | Portfolio        |
    When User selects any of the above options
    Then the following details should be displayed:
      | Lease Expiration          |
      | Top N Details             |
      | Top N by Occupant         |
      | Total Sq. Ft. and Rent PSF Scatter Chart |
    And the visual should be updated according to the selected option