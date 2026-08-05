Feature: Validate Newly Added Table in Data Model
  
     Scenario: Validate newly added table integration in CBRE Data Model and Reports
        Given the user opens the correct CBRE data model in Tabular Editor
        And the newly added table exists in the data model
        And the column descriptions of the newly added table are available
        And the column descriptions match the Mapping Document
        When the user opens the Commercial or Financial reports in Power BI Desktop
        And the reports are connected to the correct semantic model
        Then the newly added table should be visible in the report data model
        And the columns of the newly added table should be imported into the reports
        And the data should appear correctly in the report visuals
        And the data displayed in the reports should match the data available in the Warehouse