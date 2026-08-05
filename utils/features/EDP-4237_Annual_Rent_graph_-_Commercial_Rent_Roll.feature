Feature: Commercial Rent Roll

  Background:
    Given the user logs into Power BI
    And selects the appropriate workspace

  Scenario: User interacts with bar graph and views related data
    When the user opens the Commercial Rent Roll report
    And selects any <Group by> condition
    Then the bar graph should be grouped based on the selected <Group by> condition
      | Group by            |
      | Portfolio ID - Name |
      | Project ID - Name   |
      | Building ID - Name  |
    And the bar graph should have properly aligned x and y axes
      | Axes  | Name                    |
      | x     | Annual Rent             |
      | y     | Group by Condition Name |
    And the user mouse hovers on the Annual rent Chart
    Then the tooltip values should display
      | Group by Condition Name |
      | Annual Rent             |
    When the user clicks any <keycard>
    Then the bar graph title should display 'Annual rent - ' suffixed with the <keycard> name
    And the bar graph visuals should update based on the selected <keycard>
      | keycards       |
      | Total Units    |
      | Occupied Units |
      | Reserved Units |
      | Vacant Units   |

    When the user selects any bar from the graph
    Then the related data should be displayed in key cards and the Rent Roll Table
    And the data should be accurate and reflect the selected bar's details