Feature: Residential Rent Steps - Interacting with Power BI Visual

  Scenario: User interacts with a visual and its options
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to a page with a visual
    And the user hovers over the visual
    And the user clicks on the More options icon
    Then a dropdown menu should appear with additional options
    And the user should see options related to the visual's interactions
    And the user should be able to select and interact with the available options