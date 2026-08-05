Feature: Residential Vacancy Analysis

  Scenario: User interacts with the table and views grouped data

    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the report
    Then the table with headers along with proper data should be loaded

    When the user selects any of the records from the table
    Then the information related to the selected record should be displayed in <key cards> and <other visuals>
      | key cards     |
      | Vacant Units  |
      | Vacancy %     |
      | Change %      |
      
      | Other Visuals                     |
      | Vacancy % by Property             |
      | Vacant Units by Regional Manager  |

    When the user selects any of the <Group by> conditions from the table
      | Building ID - Name  |
      | Regional manager    |
      | property Manager    |
      | Class ID            |
      | Property ID - Name  |
    Then the data should be grouped based on the condition selected