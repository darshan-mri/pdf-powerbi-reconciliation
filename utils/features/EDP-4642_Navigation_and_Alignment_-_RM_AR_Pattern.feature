Feature: Residential AR Pattern

  Scenario: Verifying interaction with visual options in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to a page with a visual
    And the user hovers over the visual
    And the user clicks on the More options icon
    Then a dropdown menu should appear with additional options
    And the user should see options related to the visual's interactions
    And the user should be able to select and interact with the available options


  Scenario: User views and navigates through a Power BI report with proper alignment
      Given the User is logged into Power BI
      And the User selects the workspace
      When the User opens the report
      Then all the visuals should be properly aligned
      When the User navigates to a page with a table visual
      Then the column names in the table should be left-aligned
      And the values in the table should be right-aligned