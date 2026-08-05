Feature: Residential Lease Expiration - Interacting with Visual's More Options Menu

  Scenario: User interacts with the More options icon on a visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to a page with a visual
    And the user hovers over the visual
    And the user clicks on the More options icon
    Then A dropdown menu should appear with additional options
    And The user should see options related to the visual's interactions
    And The user should be able to select and interact with the available options