Feature: Filter Pane - AH Annual Certifications

  Scenario: User interacts with the Filter Pane in the AH Annual Certifications report
    Given the user is logged into Power BI
    And has selected the appropriate Workspace
    And opened the "AH Annual Certifications" report
    And the report visuals are fully loaded without any breakage

    Then the Filter Pane should be hidden by default
    And should be located on the right side of the report

    When the user clicks the "Show/hide" filter pane icon
    Then the Filter Pane should become visible
    And display all available page-level filters:
      | Filter Name |
      | Date        |
    And the default filter selections should be:
      | Filter Name | Default Selection |
      | Date        | Relative Date     |

    When the user selects a filter value from the Filter Pane
    Then the report visuals should update based on the selected filter

    When the user clears the selected filter
    Then the report visuals should revert to their default state