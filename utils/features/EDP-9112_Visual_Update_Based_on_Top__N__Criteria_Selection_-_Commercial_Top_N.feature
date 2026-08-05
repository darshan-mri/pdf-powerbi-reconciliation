Feature: Commercial Top N
Scenario: User selects a Top (N) criteria option and updates visuals accordingly
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should see the "Top (N) Criteria" visual with the following options:
      | Annual Rent       |
      | Annual Rent PSF   |
      | Total Sq. Ft.     |
    When the user selects any of the above options
    Then the following visuals should be updated according to the selected option:
      | Lease Expiration                       |
      | Top N Details                          |
      | Top N by Occupant                      |
      | Total Sq. Ft. and Rent PSF Scatter Chart |