Scenario: User views the updated date in the Financial Reports workspace
    Given User logs into PowerBI
    When User selects the workspace
    And User opens Financial reports
    Then The user should be able to see the refreshed date and last data updated date in the following format: 
      | dd/MM/yyyy hh:mm:ss AM/PM |
    And The "Refreshed date" and "Last data update:" text should be the concatenation of the `lastRefresheDate` and the `DashBoardFormat` from the Datebase
    And the date can be verified in the database with the following SQL query:
      ```
      Select lastRefresheDate, DashBoardFormat 
      from portal.pipelineExecutionlog 
      where mriclientid = 'MRIDefaultQWEB' -- Update the MriClientID
      ```
    And The `lastRefresheDate` and `DashBoardFormat` should match the Updated date in report.