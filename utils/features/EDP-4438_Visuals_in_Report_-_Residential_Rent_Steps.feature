Feature:Residential Rent step - Power BI Report Loading and Visuals Integrity

  Scenario: Verifying the report loads without breaking any visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the report should load without breaking any visuals
      | As of Date                          |                         
      | Refresh Date                        |
      | Last Data Update icon               |
      | Effective Dates                     |
      | Step Range                          |
      | Rent Step by Step Range             |
      | Rent Step Count by Regional Manager |
      | Rent Step Summary                   |
      | Rent Step Details                   |