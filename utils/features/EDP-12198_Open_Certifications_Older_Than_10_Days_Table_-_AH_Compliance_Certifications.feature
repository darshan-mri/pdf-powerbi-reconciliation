Feature: Open Certification Details Table - AH Compliance Certifications
  
  Scenario: Interacting with the "Open Certification older Than 10 Days Table" Table in the AH Compliance Certifications Report
    
    Given the user is logged into PowerBI
    And the user has selected the appropriate Workspace
    And the user opens the "AH Compliance Certifications" report

    Then all visuals in the report should load without visual breakage
    And the "Open Certification Older Than 10 Days" table should be visible
    And the title of the table should update dynamically based on the value selected in 'Aged Certification Input' filter 

    Then the "Open Certification Older Than 10 Days" table should display the following columns:
      | Column Name                 |
      | Certification Phase         |
      | Action Type	                |
      | User                        |
      | Creation Date               |
      | Last Date                   |
      | Application Effective Date  |
      | Head of Household	          |
    And the table should not display certifications created within the days selected in 'Aged Certification Input' filter prior to the selected 'As Of' date

    When the user clicks on the up/down Arrow for following column Names:
      | Column Name                 |
      | Certification Phase         |
      | Action Type	                |
      | User                        |
      | Creation Date               |
      | Last Date                   |
      | Application Effective Date  |
      | Head of Household	          |

    Then the table data should be sorted in ascending or descending order based on Column Values
    When the user clicks on any row, column, or record in the table

    Then the opacity of unselected rows/columns/records should decrease
    And cross-filtering should be applied to the following visuals:

      # KeyCards
      | Visual Name           |
      | Open Certifications   |

      # Other Visuals
      | Visual Name                                             |
      | Certifications Completed Line Chart                     |
      | Open Certifications by Phase Clusterd Bar Chart         |
      | Open Certification Details Table                        |
      | Open Certifications by User Clustered Bar Chart         |

    When the user deselects the selected row/column/record

    Then the table data should revert to its default state