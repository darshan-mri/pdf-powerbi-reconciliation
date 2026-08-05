Scenario: Table header should have a border
  Given I am on the page with the data table
  Then each table header should have a visible border

Scenario: Add button spacing
  Given I am on the page
  Then the "Add" button should have appropriate spacing on the top and right

Scenario: Title alignment
  Given I am on the page
  Then the page title should be properly aligned according to the layout guidelines

Scenario: Kendo grid appears after executing the query
  Given I have filled the required fields in the query form
  When I click the "Execute" button
  Then the Kendo grid should be displayed with the query result

Scenario: MRI standard colors and fonts are applied
  Given I am viewing the page
  Then the font and colors used should match MRI design standards