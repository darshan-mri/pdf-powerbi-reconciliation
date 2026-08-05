Feature: Commercial AR Insights - More Details Keycards
Scenario Outline: User Click on More details option in keycards
Given the user is logged into Power BI
And the user has selected the appropriate workspace
When the user opens the "Commercial AR Insights Report"
And clicks on "More Details" from the "<Key Card>"
Then the total value for "<Key Card>" should be displayed
And the displayed total value should match the "<Key Card>" value

Examples:
  | Key Card            |
  | Total Open Charges  |
  | Billings            |
  | Credits             |
  | Open Charges        |