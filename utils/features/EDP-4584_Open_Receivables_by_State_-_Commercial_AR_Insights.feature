Feature: Commercial AR Insights - Open Receibales by State

  Scenario: User interacts with the map visual
    Given the user is logged into Power BI
    And the user selects the appropriate workspace
    When the user opens the Commercial AR Insights report
    Then the map visual should load with data points
    And the map should accurately display the data points on their respective locations
    When the user hovers over a region on the map
    Then a tooltip should display relevant data for that region:
      | State               |
      | Average of Latitude |
      | Average of Longitude|
      | Total Open Charges  |
    And when the user clicks on a region
    Then the map should filter other visuals based on the selected region
    When the user scrolls the mouse
    Then the map should zoom in/out
    And when the user clicks and drags anywhere on the map
    Then the map should pan to show different areas