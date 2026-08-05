Scenario Outline: Exchange Rate Filter - Financial Hub Map
  Given User logs into PowerBI
  And User Opens Financial Hub Map report from the workspace
  When User selects <Exchange Rate> filter from the filters pane
  Then the report should be updated as per the selected <Exchange Rate> filter
  And the values in the report should be updated as per the <Exchange Rate> Filter Selected
  
  Examples:
  | American Dollar |
  | Mexican Peso |