Feature: Visual Interaction Options

Scenario: Verify More options for visuals
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User navigates to a page with a visual
  And User hovers over the visual
  And User clicks on the More options icon
  Then a dropdown menu should appear with additional options
  And User should see options related to the visual's interactions
  And User should be able to select and interact with the available options