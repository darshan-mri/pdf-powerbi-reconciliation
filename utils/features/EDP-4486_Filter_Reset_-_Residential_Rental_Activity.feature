Feature: Filter Pane Interaction

Scenario: Verify filter reset functionality
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And expands the Filter show/hide pane
  Then the filter reset button should be displayed
  When User applies the filter conditions from the Filters pane
  And clicks on the filter reset button
  Then the filters applied should be set back to the default state