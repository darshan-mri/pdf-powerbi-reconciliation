Feature: Residential AR Pattern - Focus Mode Functionality for Billings and Payments Bar Graph in Power BI Report

 Scenario: Verifying Focus Mode functionality for the Billings and Payments bar graph
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And the user navigates to the Billings and Payments bar graph
    And clicks on the Focus Mode button/icon for the bar graph
    Then the bar graph visual should expand to fill the screen
    And other page elements should be hidden
    And the user should see the Back to report button
    When the user clicks on the Back to report button
    Then it should navigate back to the page