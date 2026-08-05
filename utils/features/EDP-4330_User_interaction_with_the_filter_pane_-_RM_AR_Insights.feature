Feature: Residential AR Insights

  Scenario: Verifying filter options display and data update based on selected filters
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Filter show/hide pane
    Then the following <filters> options should be displayed and the filter options should update based on the changes made and the other visuals should display the relevant data based on the filter condition selected

    | Filters              |
    | Date                 |
    | Property status      |
    | Building ID - Name   |
    | Property ID - Name   |
    | Project ID - Name    |
    | Income Description   |
    | Portfolio            |
    | Entity type          |
    | Source Code          |
    | Life code            |
    | Property type        |
    | Property sub type    |
    | Class ID             |
    | Investment Flag      |
    | Investment Type      |
    | Location ID          |
    | State ID             |
    | Unit Type            |
    | Owner                |
    | Asset manager        |
    | Department           |
    | Unit                 |
    | Resident Name        |
    | isActiveProperty     |
    | Agent                |

    And the following <filter> options should have default selections:

    | Date                | Current Date |
    | isActiveProperty    | true         |

    And the filter options should update dynamically based on the selections made
    And the visuals should display relevant data based on the selected filter conditions