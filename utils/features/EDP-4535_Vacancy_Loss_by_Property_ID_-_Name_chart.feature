Feature: Vacancy Loss Report

  Scenario: User interacts with the Vacancy Loss report

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    And the user clicks on "More Details" from the Vacancy Loss key card
    Then the x and y axes should be aligned properly

    When the user hovers over any bar in the chart
    Then the tooltip value for the bar should be displayed

    When the user clicks on any bar in the chart
    Then the data related to the selected bar should be displayed in key cards and other visuals