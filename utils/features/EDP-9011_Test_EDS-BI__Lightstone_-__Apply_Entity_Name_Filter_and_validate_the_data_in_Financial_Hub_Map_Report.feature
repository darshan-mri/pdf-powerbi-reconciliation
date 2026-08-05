Feature: Entity Name Filter
Scenario: User selects Entity Name filter and verifies the updates on key cards, Hub Map, and Hub Map Details table
    Given the user logs into Power BI
    And the user opens the "Financial Hub Map" report from the workspace
    When the user selects the "Entity Name" filter from the filters pane
    Then the values should be updated for the key cards, Hub Map, and Hub Map Details table according to the selected Entity Name filter
    And the column values of the Hub Details table should be verified by converting the DAX query to SQL