Feature: Expiring Leases Chart UI 
Scenario Outline: Verify that font size for headings is set to 9 in Decomposition of Expiring Leases Chart
  Given User logs into Power BI
  And user selects the Workspace
  When User Opens the Asset Modelling report 
  And Clicks on Decomposition of Expiring Leases Chart in Edit Mode
  Then default Font Size should be set as 9 in Visualizations->Format Visual->Visual->Headers->Title section