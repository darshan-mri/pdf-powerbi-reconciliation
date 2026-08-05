Feature: Commercial Stacking Plan

  Scenario: Displaying detailed information in the report
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on "More Details" from the "Total Units" key card
    Then the x and y axes should represent categories accurately
      | Axes  | Name  |
      | x     | Total Units |
      | y     | Floor       |
    When the user hovers over a bar on the graph
    Then a tooltip should appear displaying additional information about the bar
      | Building ID - Name |
      | Floor              |
      | Suite ID           |
      | Total Units        |
      | Lease Start        |
      | Lease End          |
      | Occupant Name      |
    When the user selects a segment of the bar
    Then the data related to the selected segment should be displayed in the key cards, stacking table, and unit information visuals