Feature: Credits Keycard - Commercial AR Insights

  Scenario: User verifies the Credits keycard value
    Given the user is logged into Power BI
    When the user selects the appropriate workspace
    And the user opens the "Commercial AR Insights" report
    Then the Credits keycard along with the "More Details" link should be visible on the report
    When user selects the <Reporting Range>
      | 30                  |
      | 60                  |
      | 90                  |
      | 120                 |
      | Trailing 12 months  |
    And the user retrieves the Credits value from the warehouse
    And the user rounds the warehouse value to the nearest million
    And the user retrieves the Credits value from the "Commercial AR Insights" report
    Then the warehouse and report values should match