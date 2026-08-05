Feature: Commercial AR Insights - Total Open AR by Year

  Scenario: User views and interacts with Total Open AR by Year
    Given the user is logged into Power BI
    And the user selects the appropriate workspace
    When the user opens the Commercial AR Insights report
    And clicks on Total Open AR by Year
    Then the user should see the data loaded properly with corresponding tooltip values for the following visuals:
      | Visual               |
      | Total Open AR by Year|
      | Billings by Year     |
      | Credits by Year      |
    And hovering on the loaded data should display tooltips with values for:
      | Tooltip Field        |
      | Total Open Charges   |
      | Billings             |
      | Credits              |
    And tooltip values should match with keycards:
      | Keycard              |
      | Total Open Charges   |
      | Billings             |
      | Credits              |