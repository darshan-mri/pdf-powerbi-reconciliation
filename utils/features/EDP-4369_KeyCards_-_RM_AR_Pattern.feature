Feature: Residential AR Pattern - Displaying Visuals with Proper Data in Power BI Report

  Scenario: Verifying that the specified visuals are displayed with the correct data
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the following visuals should be displayed with proper data:
      | Total Open Charges                           |
      | Billings                                    |
      | Credits/Payments                             |
      | Open Charges                                 |