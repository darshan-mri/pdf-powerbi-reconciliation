Feature: Dropdown Slicer UI Validation

  Scenario: Validate dropdown slicer styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Slicer height should be 56px
    And Top and bottom padding should be 16px
    And Left and right padding should be 4px
    And Border radius should be 8px