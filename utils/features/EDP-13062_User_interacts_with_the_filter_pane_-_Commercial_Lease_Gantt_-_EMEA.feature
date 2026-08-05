Feature: Commercial Lease Gantt
Scenario: User interacts with the filter pane in Power BI report
  Given User logs into Power BI
  And User selects the workspace
  When User opens the report
  And User clicks on the "Filter show/hide" pane
  Then the following filter options should be displayed:
    | Date                  |
    | Building ID - Name    |
    | Project ID - Name     |
    | Portfolio             |
    | Entity Type           |
    | Life Code             |
    | Property Type         |
    | Property Sub Type     |
    | Class ID              |
    | Investment Flag       |
    | Investment Type       |
    | Location ID           |
    | State ID              |
    | Client Name           |
    | Company Group         |
    | Suite Type            |
    | Owner                 |
    | Asset Manager         |
    | Department            |
    | Manager               |
    | Landlord              |
    | Master Occupant       |
    | Store Category        |
    | Tenant Type           |
    | Tenant Type Category  |
    | SIC Code              |
    | Unit Measurement ID   |
    | Agent                 |

  And the following filter options should have default selections:
    | Date                              | current Date     |

  And the filter options should update dynamically based on the selections made
  And the visuals should update to display relevant data based on the selected filter conditions