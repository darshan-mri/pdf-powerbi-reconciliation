Given User logs into Power BI
And User selects the workspace
When User opens the report
And Clicks on More Details from the <keycards>
Then the <Table> for the corresponding <keycards> should be displayed without any duplicate values in table.

Examples:
  | Keycards          | Table                      |
  
  | Billings          | Billing Details            |
  | Credits           | Credits and payments       |
  | Open Charges      | Open charges               |
  | Security Applied  | Security Applies           |
  | 1st Month         | 1st Month                  |
  | 2nd Month         | 2nd Month                  |
  | 3rd Month         | 3rd Month                  |
  | >=4th Month       | >=4th Month                |