Feature: Commercial AR Pattern By Period

  Scenario: Viewing, Selecting, and Deselecting Records in the Tenant AR Patterns Table
    Given the user logs into Power BI
    And the user selects the appropriate workspace
    When the user opens the "Commercial AR Pattern By Period" report
    Then the user should see the "Tenant AR Patterns" table
    And the table should contain data for the previous 12 months
    And the top-right corner of the table should display legends with the following colors:
      | Status    | Color  |
      | Overpaid  | Green  |
      | Paid      | White  |
      | Unpaid    | Red    |
    And the color logic should follow this rule:
      """
      Positive balance shows red, negative balance shows green, and zero balance shows white (Paid).
      """
    And the table should be grouped by "Master Occupant"
    And the columns should represent the "Period" (monthly)
    
    When the user selects a row or column from the "Tenant AR Patterns" table
    Then the selected row should be highlighted
    And the values in other visuals should update based on the selected row or column

    When the user selects a specific period or record from any other visual
    Then the corresponding data should be highlighted in the "Tenant AR Patterns" table

    When the user deselects the selected row or column
    Then all visuals should revert to their original state