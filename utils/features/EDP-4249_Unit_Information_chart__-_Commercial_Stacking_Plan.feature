Feature: Commercial Stacking Plan

  Scenario: User interacts with Unit Information chart and views related data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Commercial Stacking Plan report
    Then each segment of the donut chart should be labeled with its respective category value
    And the legends should display the category names accurately
      | Vacant       |
      | Year 1       |
      | Year 2       |
      | Year 3       |
      | Year 4+      |
      | Holdover/MTM |
    And hovering over a segment should display its tooltip value
      | Year  |
      | Units |
    When the user clicks on a specific segment of the donut chart
    Then the data related to the selected segment should be displayed in key cards and other visuals