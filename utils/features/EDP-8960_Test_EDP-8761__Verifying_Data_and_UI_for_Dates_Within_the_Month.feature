Scenario: To check that the data is populated correctly when selecting a date within the month
  Given the user opens Power BI
  And the user selects the workspace
  When the user selects the report
  And the user selects a date within the month (e.g., 15th December)
  Then the page should load
  And the report should be displayed without any visual break (e.g., no misalignment, no blank sections)
  And all the Visual data relevant to the selected date should be populated correctly