Feature: User Interaction with Tables, Charts, and Filters in the Financial Portfolio Hub

  Scenario: User opens Financial Portfolio Hub, views tables and charts, and interacts with filters
  Given The User logs into Power BI.
    And The User opens the Financial Portfolio Hub report from the workspace.
    Then the user should be able to see the <Tables> and <Charts> after clicking on the more-details of each keycards
    When the User hovers over the filter icon of the <Tables>
    Then the User should see the applied filters
    When the User hovers over the filter icon of the <Chart>
    Then the User should see the applied filters
    
    |Tables             | Chart                                       |
    |Revenue Table      | Revenue Line stacked column combo chart     |
    |Opex Table         | Revenue Variance Scattered chart            |
    |NOI Table          | Opex Line stacked column combo chart        |
    |Capex Table        | Opex Variance Scattered chart               |
    |Net Cashflow Table | NOI Line stacked column combo chart         |
    |Dept Table         | NOI Variance Scattered chart                |
    |Non-Opex Table     | Capex Line stacked column combo chart       |
    |                   | Capex Variance Scattered chart              |
    |                   | Net Cashflow Line stacked column combo chart|
    |                   | Net Cashflow Variance Scattered chart       |
    |                   | Dept service Line stacked column combo chart|
    |                   | Dept Service Variance Scattered chart       |
    |                   | Non-Opex Line stacked column combo chart    |
    |                   | Non-Opex Variance Scattered chart           |