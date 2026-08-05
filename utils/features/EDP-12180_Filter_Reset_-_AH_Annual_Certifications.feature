Feature: Filter Reset - AH Annual Certifications

  Scenario: User clicks on Filter Reset Button
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens "AH Annual Certifications" report
    And expands the Filter by clicking Show/hide filter pane icon
    Then the 'Filter Reset' button should be displayed
    When the user applies the filter conditions from the Filters pane
    And clicks on the Filter reset button
    Then the filters applied should be set back to the default state