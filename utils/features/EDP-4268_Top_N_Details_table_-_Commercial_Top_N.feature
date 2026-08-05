Feature: Commercial Top N

  Scenario: Interacting with table records
    Given the user logs into Power BI
    And the user selects the workspace
    When the user opens the Commercial Top N report
    Then the table headers along with proper data should be loaded
    And the following Column Names should be present in the table:
      #Column Names
      | Occupant        |
      | Total Sq. Ft    |
      | Annual Rent     |
      | Annual Rent PSF |
      | Rank            |
    
    When the user clicks on the up/down Arrow for following column Names:
      #Column Names
      | Occupant        |
      | Total Sq. Ft    |
      | Annual Rent     |
      | Annual Rent PSF |
      | Rank            |

    Then the table data should be sorted in ascending or descending order based on Column Values
      
    When the user selects any of the records from the table
    Then the data related to the selected record should be displayed in the other visuals
      | Lease Expiration  |
      | Top N by Grouping bar graph  |
      | Total Sq. ft. and Rent PSF Scatter Chart  |