Given User logs into Power BI
And User selects the workspace
When User opens the report
Then the User should be able to slice the lower and upper range or should be able to edit the limits from the Total Open Charges slicer
When the User adjusts the lower and upper limits from the slicer
Then the records should be limited based on the range selected in all the visuals