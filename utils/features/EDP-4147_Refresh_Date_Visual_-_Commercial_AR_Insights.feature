Feature: Commercial AR Insights - Update/Refreshed Date
Scenario: Verify updated date format in Commercial AR Insights Report
  Given User logs into Power BI
  When User selects the workspace
  And User opens the Commercial AR Insights Report
  Then User should see the updated date in the format: 
    | mm/dd/yyyy hh:mm:ss AM/PM timezone |
  And The updated date should be the concatenation of `lastRefresheDate` and `DashBoardFormat` from the database
  And The date can be verified in the database with the following SQL query:
    """
    SELECT lastRefresheDate, DashBoardFormat 
    FROM portal.pipelineExecutionlog 
    WHERE mriclientid = 'MRICLIENTID' -- Update the MriClientID
    """
  And The `lastRefresheDate` and `DashBoardFormat` should match the updated date in the report