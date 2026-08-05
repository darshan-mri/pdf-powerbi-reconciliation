Feature: Commercial Rent Roll

  Scenario: User checks filters applied on visuals
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Filter show/hide pane
    Then check the filters applied on the visuals