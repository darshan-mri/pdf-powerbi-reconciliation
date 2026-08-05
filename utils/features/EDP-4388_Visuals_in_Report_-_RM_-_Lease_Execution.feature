Feature: Residential Lease Execution

  Scenario: User logs into Power BI and views a report in a selected workspace
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The report should load without breaking any visuals
    And The report should include data related to Residential Lease Execution
      | ----------Visuals-----------|
      | Lease Count Keycard         |
      | Rent Change % Keycard       |
      | Execution Date              |
      | Rental Analysis chart       |
      | Lease Details Table         | 
      | Rent Change % Year on year  |