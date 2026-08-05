Feature: Residential AR Insights

  Scenario: User interacts with the More options icon for a visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User navigates to a page with a visual
    And User hovers over the visual
    And User clicks on the "More options" icon
    Then A dropdown menu should appear with additional options
    And User should see options related to the visual's interactions
    And User should be able to select and interact with the available options