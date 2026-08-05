Scenario: User views the updated date in the Residential Reports workspace
    Given User logs into PowerBI
    When User selects the workspace
    And User opens Residential reports
    Then The user should be able to see the updated date in the following format: 
      | mm/dd/yyyy hh:mm:ss a  timezone |
    And The updated date should be the concatenation of the `lastRefresheDate` and the `DashBoardFormat` from the Datebase
    And the date can be verified in the database with the following SQL query:
      ```
      Select lastRefresheDate, DashBoardFormat 
      from portal.pipelineExecutionlog 
      where mriclientid = 'MRIDefaultQWEB' -- Update the MriClientID
      ```
    And The `lastRefresheDate` and `DashBoardFormat` should match the Updated date in report.