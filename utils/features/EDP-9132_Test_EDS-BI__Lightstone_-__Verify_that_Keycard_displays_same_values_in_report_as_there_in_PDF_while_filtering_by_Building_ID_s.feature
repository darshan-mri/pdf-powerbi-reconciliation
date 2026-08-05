Feature: Lighstone Commercial AR Patterns
Scenario Outline: Verify that keycard displays same values in report as there in PDF while filtering report by BuildingId's
  Given User logs into Power BI
  And User selects Workspace
  When User opens the Lightstone Commercial AR Patterns report
  Then User should be able to see the <Keycards>
  And User should be able to select the Building Id from the Filter pane
  When User selects the required Building ID in the Filter Pane
  Then The <Keycards> value should be displayed as same as in the PDF
  When the measures for <Keycards> is updated 
  Then validate the data in the Database

  Examples:
    | Keycards            |
    | Total Open Charges  |
    | Total Billings      |
    | Total Credits       |
    | 1st Month           |
    | 2nd Month           |
    | 3rd Month           |
    | 4+ Months           |