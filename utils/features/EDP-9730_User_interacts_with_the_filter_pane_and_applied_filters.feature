Feature: ML Reality Financial details report   
 
  Scenario: User interacts with the filter pane in Power BI report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the "Filter show/hide" pane
    Then the following filter options should be displayed:
      | Period                |
      | Variance Type         |
      | Group By              |
      | Active Entities       |
      | Basis                 |
      | MRI Financial Formats |
      | Entity type           |
      | Life code             |
      | Property type         |
      | Property sub type     |
      | Class ID              |
      | Investment ID         |
      | Investment flag       |
      | Location ID           |
      | State ID              |
      | Client Name           |
      | Suite type            |
      | Owner                 |
      | Asset manager         |
      | Department            |
      | Region                |
      | Project ID - Name     |
      | Entity ID - Name      |
      | Blanace forward       |
      | Budget type           |
      | Portfolio ID - Name   |
      
    And the following filter options should have default selections:
      | Period                | current Period      |
      | Budget type           | STD. Budget         |
      | Variance Type         | Is blended forcast  |
      | Group By              | Entity ID - Name    |
      | Active Entities       | Y                   |
      | Basis                 | Accrual             |
  
    And the filter options should update dynamically based on the selections made
  And the visuals should display relevant data based on the selected filter condition