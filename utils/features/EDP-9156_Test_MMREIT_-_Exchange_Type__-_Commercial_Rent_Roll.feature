Feature: Commercial Rent Roll report

  Scenario Outline: User filters the lease data by currency type
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should be able to see the Exchange Type dropdown with the currency options
    When the user selects "<Currency>" from the Exchange Type dropdown
    Then the value should be updated as per the selected "<Currency>" Option
    And the currency symbol should be "<Symbol>"

    Examples:
      | Currency          | Symbol |
      | American Dollar   | $      |
      | Mexican Peso      | $      |