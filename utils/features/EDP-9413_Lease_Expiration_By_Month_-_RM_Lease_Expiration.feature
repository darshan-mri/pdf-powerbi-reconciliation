Scenario: Viewing and interacting with Lease Expiration data
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the user should see the "Lease expiration by month" bar graph visual without any breakage
    And the user should see the <options> on the visual
    When the user selects any <option> from the list
    Then the visual should be updated according to the selected option
    When the user selects the lease expiration table
    Then the visual should switch to display the table view
    When the user switches back to the "Lease expiration by month" chart
    Then the chart should remain on the selected option
    
      | Examples           |  
      | Options            |
      | Building ID - Name |
      | Regional Manager   |
      | Property Manager   |
      | Bed and Bath       |
      | Class ID           |
      | No grouping        |
      | Property ID - Name |