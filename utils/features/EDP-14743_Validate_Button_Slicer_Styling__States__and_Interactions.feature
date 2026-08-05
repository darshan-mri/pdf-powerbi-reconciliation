Feature: Button Slicer UI Validation

  Scenario: Validate button slicer styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Slicer button height should be 40px
    And Font size should be 12pt Segoe UI
    And Outline color should be #909FAE
    And Selected state should be #3A9DD2 with 80% transparency
    And Hover state should be #3A9DD2 with 30% transparency
    And Pressed state should have 3px border #3A9DD2
    And Border radius should be 8px