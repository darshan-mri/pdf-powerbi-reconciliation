Feature: Residential AR Pattern  
  
  Scenario: User interacts with table data in Power BI report (view, sort, and select record)
      Given the User is logged into Power BI
      And the User selects the workspace
      When the User opens the report
      Then the table headers along with proper data should be loaded
      When the User clicks on any column name
      Then the table data should be sorted in ascending order by default
      When the User clicks again on the column name
      Then the table data should be sorted in descending order
      When the User selects any of the records from the table
      Then the information related to the selected record should be displayed in key cards and other visuals