Feature: Commercial Stacking Plan

  Scenario: User interacts with bar graph and views relevant details
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Commercial Stacking Plan report
    Then the bar graph with x and y axis names should be displayed and aligned properly
      | Axes  | Name            |
      | x     | % of Floor      |
      | y     | Floor           |
    When User hovers the mouse over a bar
    Then the User should be able to see the tooltip value for the bar over which the mouse is hovered upon
      | Building ID-Name     |
      | Floor                |
      | Suite ID             |
      | % of Floor           |
      | Lease Start          |
      | Lease End            |
      | Occupant Name        |
    When User selects a bar from the bar graph
    Then the relevant details should be displayed in key cards, Stacking Plan, Stacking table, and Unit Information Chart