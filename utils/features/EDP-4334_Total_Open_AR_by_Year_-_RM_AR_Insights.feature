Feature: Residential AR Insights


  Scenario: User opens the report and verifies the data and tooltip values for the visuals
      Given the user logs into Power BI
      And the user selects the workspace
      When the user opens the report
      And clicks on "Total Open AR by Year"
      Then the user should see the data loaded properly with their corresponding tooltip values for the following visuals:
        | Visuals               |
        |-----------------------|
        | Total Open AR by Year |
        | Billings by Year      |
        | Credits by Year       |
      And the Billings and Credits by Year values should match with the respective keycard values.