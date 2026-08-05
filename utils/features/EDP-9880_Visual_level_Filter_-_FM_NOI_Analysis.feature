Feature: Visual Interaction - No Filters Applied

  Scenario: User clicks on a visual and sees no filters applied
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User clicks on any visual in the report
    Then The user should not see any filters applied on the visual