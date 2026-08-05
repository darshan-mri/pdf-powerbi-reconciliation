Feature: Commercial AR Insights By Period with Currency Exchange Visual Interaction

  Scenario Outline: Currency Exchange Visual - Commercial AR Insights By Period
    Given the user logs into Power BI
    And the user opens the Commercial AR Insights By Period report from the workspace
    When the user selects "<Currency>" from the currency filter in the filters pane
    Then the report should be updated based on the selected "<Currency>" filter
    And the values in the report should reflect the selected "<Currency>"
    And the currency symbol should be "$"

    Examples:
      | Currency          |
      | American Dollar   |
      | Mexican Peso      |