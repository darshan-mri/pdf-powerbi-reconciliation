Feature: Commercial AR Insights - Open Receivables Details table

  Scenario: User views and interacts with the Open Receivables Details table
    Given the user is logged into Power BI
    And the user selects the appropriate workspace
    When the user opens the Commercial AR Insights report
    And clicks on the Open Receivables Details' Table button
    Then the user should be able to see the table headers along with the data loaded properly
    And based on the Reporting Range Selected in the slicer, data should be restricted in the table
    When the user selects any of the records from the table
    Then the information related to the selected record should be displayed in key cards and other visuals