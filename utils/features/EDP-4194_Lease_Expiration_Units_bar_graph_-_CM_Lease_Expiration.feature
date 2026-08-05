Feature: Commercial Lease Expiration

  Scenario: Display and interact with bar graph based on Expiry Grouping
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the Commercial Lease Expiration report
    And selects an <Expiry Grouping>:
      | Expiry Grouping |
      | Monthly Rent    |
      | Total Sq. Ft    |
    Then the user should see a bar graph with properly aligned axes:
      | Axis | Name                  |
      | x    | Expiry date           |
      | y    | <Expiry Grouping> Name  |
    And hovering over a bar should display a tooltip with the corresponding values:
      | Expiration Date         |
      | Property Name           |
      | <Expiry Grouping> Name  |
      | Annual Rent             |
    When the user selects a bar from the chart
    Then the related information should be displayed in Lease Details and Expiry Bandings Visuals.