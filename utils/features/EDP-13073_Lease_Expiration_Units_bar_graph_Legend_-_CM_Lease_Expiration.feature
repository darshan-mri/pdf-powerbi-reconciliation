Feature: Commercial Lease Expiration

  Scenario: Display Lease Expiration Units bar graph with correct legend alignment
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the Commercial Lease Expiration report
    Then the Lease Expiration Units bar graph should be displayed
    And the bar graph legend should be aligned at the center right