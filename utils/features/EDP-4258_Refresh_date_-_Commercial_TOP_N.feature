Feature: Commercial Top N
Scenario: Verify updated date format in Commercial Top N Dashboard Report
  Given User logs into Power BI
  When User selects the workspace
  And User opens the Commercial Top N Dashboard Report
  Then User should see the updated date in the format: 
    | mm/dd/yyyy hh:mm:ss timezone |
  And The updated date should be the concatenation of `lastRefresheDate` and `DashBoardFormat` from the database
  And The date can be verified in the database with the following SQL query:
    """
    SELECT lastRefresheDate, DashBoardFormat 
    FROM portal.pipelineExecutionlog 
    WHERE mriclientid = 'MRIDefaultQWEB' -- Update the MriClientID
    """
  And The `lastRefresheDate` and `DashBoardFormat` should match the updated date in the report