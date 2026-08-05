Feature: Filter Pane Interaction in Power BI Report

  Scenario: User interacts with the filter pane in the Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the "Filter show/hide" pane
    Then The following filter options should be displayed:
      | Period                |
      | Variance type         |
      | Group by              |
      | Active Entities       |
      | Basis                 |
      | MRI Financial Format  |
      | Portfolio Name        |
      | Project               |
      | Entity Type           |
      | Entity Name           |
      | Life Code             |
      | Property Type         |
      | Property Sub Type     |
      | Class ID              |
      | Investment Flag       |
      | Investment Type       |
      | Location ID           |
      | State ID              |
      | Class Name            |
      | Suite Type            |
      | Owner                 |
      | Asset Manager         |
      | Department            |
      | Region                |
      | Budget Type           |
      | Balance Forward       |
      | Agent                 |

    And the following filter options should have default selections:
      | Period                | Current Period          |
      | Group By              | Is Master Occupant      |
      | Variance Type         | Is Blended Forecast     |
      | Active Entities       | Is Y                    |
      | Basis                 | Is Accrual              |
      | Budget Type           | STD.Budget              |
      | Balance Forward       | N                       |

    And the filter options should update dynamically based on the selections made
    And the visuals should display relevant data based on the selected filter conditions