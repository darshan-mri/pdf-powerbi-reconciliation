Feature: Filters Benderson Financial GL Details
Scenario: User Interacts with Filter Pane
Given User logs into PowerBI
And User Opens Financial GL Details report of Benderson client from the workspace
When User applies <Filters> with different combinations or indivisual from the filter pane
Then the visuals should be updated and values should be displayed according to the selected  filters
When User hovers over the Filters icon in the Transaction Details table
Then User should see the applied filters


  
| Filters              |
| Period               |
| Group by Hierarchy   |
| Group By             |
| Group By (Level 2)   |
| Basis                |
| Portfolio            |
| Entity Type          |
| Entity Type ID       |
| Use ID               |
| Dev Type ID          |
| Sag Code ID          |
| Client Name          |
| MRI Financial Formats|
| GL Reference         |
| GL Descreption       |
| Account Number       |
| Account Name         |
| Life code            |
| Property type        |
| Property sub type    |
| Class ID             |
| Investement flag     |
| Invedtemnet type     |
| Location ID          |
| State ID             |
| Suite Type           |
| Owner                |
| Asset maneger        |
| Departmenet          |
| Region               |
| Cost center          |
| Cost center Owner    |
| District_D           |
| District_H           |
| Developmentgroup_D   |
| Developmentgroup_H   |
| Project ID - Name    |
| Entity ID - Name     |
| Balance forward      |