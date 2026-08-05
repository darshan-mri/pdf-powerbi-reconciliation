Feature: Financial Details with Currency Exchange Visual Interaction

  Scenario Outline: Currency Exchange Visual - Financial Details
    Given the user logs into Power BI
    And the user opens the Financial Details report from the workspace
    When the user selects "<Currency>" from the currency filter in the filters pane
    Then the report should be updated based on the selected "<Currency>" filter
    And the values in the report should reflect the selected "<Currency>"
    And the currency symbol should be "$"

    Examples:
      | Currency          |
      | American Dollar   |
      | Mexican Peso      |