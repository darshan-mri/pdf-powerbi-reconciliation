Feature: Interactions with Tables and Charts in the Financial Portfolio Hub

  Scenario: User opens Financial Portfolio Hub and interacts with tables and charts in the more details view
    Given The User logs into Power BI
    And The User opens the Financial Portfolio Hub report from the workspace
    Then The User should be able to see the following tables and charts after clicking on the more-details of each keycard:
      | Tables             | Chart                                       |
      | Revenue Table      | Revenue Line stacked column combo chart     |
      | Opex Table         | Revenue Variance Scattered chart            |
      | NOI Table          | Opex Line stacked column combo chart        |
      | Capex Table        | Opex Variance Scattered chart               |
      | Net Cashflow Table | NOI Line stacked column combo chart         |
      | Dept Table         | NOI Variance Scattered chart                |
      | Non-Opex Table     | Capex Line stacked column combo chart       |
      |                    | Capex Variance Scattered chart              |
      |                    | Net Cashflow Line stacked column combo chart|
      |                    | Net Cashflow Variance Scattered chart       |
      |                    | Dept Service Line stacked column combo chart|
      |                    | Dept Service Variance Scattered chart       |
      |                    | Non-Opex Line stacked column combo chart    |
      |                    | Non-Opex Variance Scattered chart           |

  Scenario Outline: User clicks on Focus mode for a table and chart and views them in full screen
    Given The User logs into Power BI
    And The User opens the Financial Portfolio Hub report from the workspace
    When The User clicks on Focus mode for the <Table> and <Chart>
    Then The <Table> and <Chart> should be displayed in full screen with the lines and values intact
    And There should be a back button to navigate back to the home page

    Examples:
      | Table             | Chart                                       |
      | Revenue Table      | Revenue Line stacked column combo chart     |
      | Opex Table         | Revenue Variance Scattered chart            |
      | NOI Table          | Opex Line stacked column combo chart        |
      | Capex Table        | Opex Variance Scattered chart               |
      | Net Cashflow Table | NOI Line stacked column combo chart         |
      | Dept Table         | NOI Variance Scattered chart                |
      | Non-Opex Table     | Capex Line stacked column combo chart       |
      |                    | Capex Variance Scattered chart              |
      |                    | Net Cashflow Line stacked column combo chart|
      |                    | Net Cashflow Variance Scattered chart       |
      |                    | Dept Service Line stacked column combo chart|
      |                    | Dept Service Variance Scattered chart       |
      |                    | Non-Opex Line stacked column combo chart    |
      |                    | Non-Opex Variance Scattered chart           |