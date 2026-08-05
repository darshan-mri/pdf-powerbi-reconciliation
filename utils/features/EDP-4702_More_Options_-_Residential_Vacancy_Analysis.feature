Feature: Reseidential Vacancy Analysis

  Scenario: User interacts with More options
    Given the user is logged into Power BI
    And the user selects a workspace
    When the user opens a report
    And navigates to a page with a visual
    And hovers over the visual
    And clicks on the "More options" icon
    Then a dropdown menu should appear with additional options
    And the user should see options related to the visual's interactions
    And the user should be able to select and interact with the available options