Feature: Filters Asset Modelling TOP N
Scenario Outline: Verify that Filters 'Portfolio ID - Name' and 'Project ID - Name' is available in TOP N Dashboard report
  Given User logs into Power BI
  And User Selects Workspace	
  When User opens the Asset Modelling report 
  And Clicks on Show/hide filter pane
  Then the <Filters> should be available in Filter Pane
  When User Click on <Filters>
  Then the <Visuals> in the report should be updated based on the <Filters> selected
  Examples:
    | Filters |
    | Portfolio ID - Name |
    | Project ID - Name |
    
    | Visuals |
    | Lease Expiration |
    | Top N Details |
    | Top N by "Grouping" |
    | Total Sq. Ft. and Rent Scatter Chart |Asset