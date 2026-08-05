Feature: Financial GL Details Report Row Selection and Keycard Update Feature

  Scenario: Ensure row selection updates the Total Amount keycard and highlights the row
    Given User logs into PowerBI
    And User opens Financial GL Details report from the workspace
    When User selects any row in the Transaction Details table
    Then the selected row should be highlighted
    And the Total Amount keycard value should be updated according to the selected row
    And opacity of unselected rows should be reduced