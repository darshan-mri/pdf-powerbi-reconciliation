Feature: Residential AR Pattern

  Scenario: User views and selects data from the chart in Power BI report
        Given the User is logged into Power BI
        And the User selects the workspace
        When the User opens the report
        Then the table headers along with proper data should be loaded
        When the User selects any bar from the chart
        Then the information related to the selected record should be displayed in key cards and other visuals
        When user deselect the selected bar the data should be reverted back in the report