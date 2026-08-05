Feature: Commercial Lease Gantt
Scenario: Verify updated date format in Commercial Lease Gantt Report
  Given User logs into Power BI
  When User selects the workspace
  And User opens the Commercial Lease Gantt Report
  Then User should see the updated date in the format: 
    | mm/dd/yyyy hh:mm:ss AM/PM timezone |
  And The updated date should be the concatenation of `lastRefresheDate` and `DashBoardFormat` from the database
  And The date can be verified in the database with the following SQL query:
    """
    SELECT lastRefresheDate, DashBoardFormat 
    FROM portal.pipelineExecutionlog 
    WHERE mriclientid = 'MRIDefaultQWEB' -- Update the MriClientID
    """
  And The `lastRefresheDate` and `DashBoardFormat` should match the updated date in the report