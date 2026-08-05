Feature: Late Certifications Table - AH Annual Certifications

  Scenario: Interacting with the "Late Recertifications" Table in the AH Annual Certifications Report

    Given the user is logged into PowerBI
    And the user has selected the appropriate Workspace
    And the user opens the "AH Annual Certifications" report

    Then all visuals in the report should load without visual breakage
    And the "Late Recertifications" table should be visible
    And a KeyCard should display Totals for Late Recertification in the upper-right corner of the Visual 

    Then the "Late Recertifications" table should display the following columns:
      | Column Name                           |
      | UserID                                |
      | Late Recertification Table contents   |
    And the totals displayed in the table should match with the totals displayed in keycard at upper-right corner


    When the user clicks on the up/down Arrow for following column Names:
      | Column Name                           |
      | UserID                                |
      | Late Recertification Table contents   |

    Then the table data should be sorted in ascending or descending order based on Column Values
    When the user clicks on any row, column, or record in the table

    Then the opacity of unselected rows/columns/records should decrease
    And data in the report should be limited to the following visuals:

      # KeyCards
      | Visual Name                                |
      | Average Days to Complete - Last 12M        |
      | Recertifications Due 90 Days               |

      # Other Visuals
      | Visual Name                                              |
      | Annual Recertification Line Chart                        |
      | Certification Load Table                                 |
      | Average Days to Completion Clustered Bar Chart           |
      | Annual Recertification Details Table                     |
      | Average Days to Completion: Rolling Prior 3 Years        |

    When the user deselects the selected row/column/record

    Then the table data should revert to its default state