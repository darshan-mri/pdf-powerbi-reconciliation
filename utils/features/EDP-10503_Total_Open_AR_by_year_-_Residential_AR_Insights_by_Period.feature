Feature: Residential AR Insights by Period - Total Open AR by Year pie charts

  Scenario: User views and interacts with Total Open AR by Year
    Given the user is logged into Power BI
    And the user selects the workspace
    When the user opens the Residential AR Insights by Period report
    And clicks on Total Open AR by Year
    Then the user should see the data loaded properly for the following chart
      | Total Open AR By year  |
      | Billing By Year        |
      | Credit By Year         |
    And hovering on the loaded data should display tooltips with values for:
      | Tooltip Field          |
      | Year                   |
      | By period Open Charges |
    And the Tooltip Value for Open Charges/billings/credits should match with Open Charges Keycard
    When the user clicks on chart
    Then the following visuals should be updated as per the selected data:
      | Open Charges keycard    |
      | Open Receivables Trends |
      | Open Charges table      |
      | Open Receivables by State|