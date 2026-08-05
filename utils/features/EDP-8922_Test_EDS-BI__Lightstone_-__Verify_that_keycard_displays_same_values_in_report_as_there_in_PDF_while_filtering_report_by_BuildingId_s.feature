Feature: Keycards Lightstone Commercial Stacking Plan
Scenario Outline: Verify that keycard displays same values in report as there in PDF while filtering report by BuildingId's
  Given User logs into Power BI
  And User selects Workspace
  When User opens the report
  Then User should be able to see the <Keycards>
  And User should be able to select the Building Id from the Filter pane
  When User selects the required Building ID in the Filter Pane
  Then The <Keycards> value should be displayed as same as in the PDF
  And if the measures for <Keycards> is updated 
  Then Validate the data in the Database

  Examples:
    | Keycards       |
    | Total Units    |
    | Vacant Units   |
    | Year 1 Units   |
    | Year 2 Units   |
    | Year 3 Units   |
    | Year 4+ Units  |
    | Holdover/MTM   |