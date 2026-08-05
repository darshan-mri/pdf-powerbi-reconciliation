Feature: User Interactions with Financial NOI Analysis Report
  
  Scenario: User views and sorts the NOI Variance Breakdown table
      Given User logs into Power BI
      When User selects the workspace
      And User opens the "Financial NOI Analysis" report
      Then User should be able to see the "NOI Variance Breakdown" table with the proper column names
      When User clicks on any of the column names in the "NOI Variance Breakdown" table
      Then User should see the values sorted based on the selected column