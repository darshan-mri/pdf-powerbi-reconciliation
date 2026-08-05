Feature: Commercial AR Patterns

  Scenario: Verify updated date format in Commercial AR Patterns Report
    Given the user is logged into Power BI
    When the user selects the workspace
    And the user opens the Commercial AR Patterns Report
    Then the user should see the updated date in the format:
      | mm/dd/yyyy hh:mm:ss timezone |
    And the updated date should be the concatenation of `lastRefresheDate` and `DashBoardFormat` from the database
    And the date can be verified in the database with the following SQL query:
      """
      SELECT lastRefresheDate, DashBoardFormat 
      FROM portal.pipelineExecutionlog 
      WHERE mriclientid = 'MRIDefaultQWEB' -- Update the MriClientID
      """
    And the `lastRefresheDate` and `DashBoardFormat` should match the updated date in the report