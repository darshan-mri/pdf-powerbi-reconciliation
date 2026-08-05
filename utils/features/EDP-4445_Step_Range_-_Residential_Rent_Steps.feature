Feature: Residential Rent Step - Step Range Selection and Data Display

  Scenario: Verifying data display based on selected Step Ranges
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then the user should be able to select any/all of the <Step Ranges>
    When user selects any/all of the <Step Ranges>
    Then the data should be displayed based on the selected <Step Ranges>
      | Step Ranges           |
      | <-20                  |
      | >=-20 and <0          |
      | No Change             |
      | >0 and <=20           |
      | >20                   |
      | Single Step           |