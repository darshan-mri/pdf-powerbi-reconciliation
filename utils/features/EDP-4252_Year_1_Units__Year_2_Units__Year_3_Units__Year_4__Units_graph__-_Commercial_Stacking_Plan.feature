Feature: Commercial Stacking Plan

  Scenario: Displaying detailed information for Yearly Units
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on "More Details" from the <key card>
    Then the bar graph for the selected year units along with the x and y axes should be aligned properly
    When the user hovers over a bar on the graph
    Then a tooltip should appear displaying information about the bar as follows:
      | Bulding ID       |
      | <Key card> Units |
    
    When the user selects a segment of the bar
    Then the data related to the selected segment should be displayed in the key cards and other visuals
      | Key card        |
      | Year 1 Units    |
      | Year 2 Units    |
      | Year 3 Units    |
      | Year 4+ Units   |