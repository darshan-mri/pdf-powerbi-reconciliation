Feature: Residential Lease Execution - Filters on Visual Icon

  Scenario: User hovers over the Filters on visual icon to see applied filters on a visual
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And User hovers the mouse over the Filters on visual icon for any of the visuals
    Then The filters applied on the visual should be displayed