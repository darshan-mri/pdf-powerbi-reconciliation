Feature: Commercial AR Insights - Open Receivables Summary table
Scenario: User views and interacts with the Open Receivables Summary table
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the report
    And clicks on the Open Receivables Summary table
    Then the user should be able to see the table headers and column name along with their data loaded properly
      | Column Names        |
      | Month & Year        |
      | Portfolio           |
      | Property ID - Name  |
      | Building ID - Name  |
      | Aged Open Charges   |
      | Aged Billings       |
      | Aged Credits        |
      | Total Open Charges  |
      | Total Credits       |
      | Total Billings      |
    When the user selects any of the records from the table
    Then the information related to the selected record should be displayed in key cards
    And the visuals should reflect according to the selection