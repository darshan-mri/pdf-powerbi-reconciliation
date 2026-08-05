Feature: Residential Lease Expiration - Display Filters Applied on Visuals

  Scenario: User interacts with Filters on Visual icon to view applied filters
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And hovers the mouse over the Filters on visual icon for any of the visuals
    Then The filters applied on the visual should be displayed