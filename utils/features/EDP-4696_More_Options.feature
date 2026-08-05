Feature: More Options
Scenario: User interacts with the More options menu on a visual

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And navigates to a page with a visual
    And hovers over the visual
    And clicks on the "More options" icon
    Then a dropdown menu should appear with additional options
    And the user should see options related to the visual's interactions
    And the user should be able to select and interact with the available options