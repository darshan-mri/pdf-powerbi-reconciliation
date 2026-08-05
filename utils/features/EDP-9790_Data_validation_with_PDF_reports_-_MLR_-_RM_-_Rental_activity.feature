Scenario: Validate report visuals with proper data and matching PDF Values
  Given User logs into PowerBI
  And User selects a workspace
  When User opens the report
  Then User should see all the visuals with proper data loading without any null, nil, or blank values
  And All visual values should match with the PDF report values