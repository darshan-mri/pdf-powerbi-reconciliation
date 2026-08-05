Feature: Residential Lease Execution - Execution Date Slicer Interaction

  Scenario: User logs into Power BI, interacts with the Execution Date slicer, and views filtered data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And inputs the lower and upper limits in the Execution Date slicer
    Then The data in all the visuals should get limited based on the range selected/entered