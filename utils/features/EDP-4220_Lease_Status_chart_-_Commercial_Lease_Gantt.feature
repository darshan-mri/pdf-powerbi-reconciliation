Feature: Commercial Lease Gantt

  Scenario: Interact with Lease Status pie chart in Power BI
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the Lease Status pie chart should represent the distribution of percentages of different Lease Statuses
    And hovering over a section should display the tooltip value
    When the user selects any of the segments from the chart
    Then the data related to the selected segment should be displayed in Lease Details and Lease Period