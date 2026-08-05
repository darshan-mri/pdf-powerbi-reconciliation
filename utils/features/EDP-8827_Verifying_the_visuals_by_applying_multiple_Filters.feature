Feature: Filters Benderson Financial Details
Scenario: User applies filters in the Financial Details report for Benderson client and views updated visuals
  Given User logs into PowerBI
  And User opens the Financial Details report for the Benderson client from the workspace
  When User applies <Filters> with different combinations or individually from the filter pane
  Then The visuals should be updated and values should be displayed according to the selected filters
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
  | GL Description       |
  | Account Number       |
  | Account Name         |
  | Life Code            |
  | Property Type        |
  | Property Sub Type    |
  | Class ID             |
  | Investment Flag      |
  | Investment Type      |
  | Location ID          |
  | State ID             |
  | Suite Type           |
  | Owner                |
  | Asset Manager        |
  | Department           |
  | Region               |
  | Cost Center          |
  | Cost Center Owner    |
  | District_D           |
  | District_H           |
  | Development Group_D  |
  | Development Group_H  |
  | Project ID - Name    |
  | Entity ID - Name     |
  | Balance Forward      |