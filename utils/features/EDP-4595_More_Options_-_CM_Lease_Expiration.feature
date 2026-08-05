Feature: Commercial Lease Expiration

  Scenario: User interacts with visual options in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And the user navigates to a page with a visual
    And the user hovers over the visual
    And the user clicks on the More options icon
    Then the dropdown menu should appear with additional options
    And the user should see options related to the visual's interactions
    And the user should see options for formatting, customization, and exporting
    And the user should be able to select and interact with the available options