Feature: Commercial Stacking Plan

  Scenario: Displaying detailed information for Holdover / MTM
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on "More Details" from the "Holdover / MTM" key card
    Then the bar graph for Holdover / MTM along with the x and y axes should be aligned properly
    When the user hovers over a bar on the graph
    Then a tooltip should appear displaying information about the bar as follows:
      | Building ID          |
      | Holdover / MTM units |
    When the user selects a segment of the bar
    Then the data related to the selected segment should be displayed in the key cards, stacking table, and unit information visuals