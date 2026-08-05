Feature: Residential AR Insights

  Scenario Outline: User applies filters from the filter pane and visuals update accordingly
    Given The User logs into Power BI
    And The User opens the Residential AR Insights report from the workspace
    When The User applies the <Filters> from the filter pane
    Then The visuals in the report are updated, and values are displayed according to the selected filter

  Examples:
    | Filters             |
    | Date                |
    | Property status     |
    | Building ID - Name  |
    | Property ID - Name  |
    | Project ID - Name   |
    | Income Description  |
    | Portfolio           |
    | Entity Type         |
    | Source code         |
    | Life code           |
    | Property type       |
    | Property sub type   |
    | Class ID            |
    | Investment flag     |
    | Investment Type     |
    | Location ID         |
    | State ID            |
    | Unit Type           |
    | Owner               |
    | Asset manager       |
    | Department          |
    | Unit                |
    | Resident Name       |