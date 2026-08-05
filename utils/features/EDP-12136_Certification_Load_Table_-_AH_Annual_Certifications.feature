Feature: Certification Load Table - AH Annual Certifications

  Scenario: Interacting with the "Certification Load" Table in the AH Annual Certifications Report

    Given the user is logged into PowerBI
    And the user has selected the appropriate Workspace
    And the user opens the "AH Annual Certifications" report

    Then all visuals in the report should load without visual breakage
    And the "Certification Load" table should be visible

    Then the "Certification Load" table should display the following columns:
      | Column Name                    |
      | UserID                         |
      | Recertification Date Columns   |
      | Total                          |

    And the "Recertification Date" column headers should follow the format "MMM YY"

    When the user clicks on the up/down Arrow for following column Names:
      | Column Name |
      | UserID      |
      | Total       |

    Then the table data should be sorted in ascending or descending order based on Column Values
    When the user clicks on any row, column, or record in the table

    Then the opacity of unselected rows/columns/records should decrease
    And cross-filtering should be applied to the following visuals:

      # KeyCards
      | Visual Name                                |
      | Average Days to Complete - Last 12M        |
      | Recertifications Due 90 Days               |

      # Other Visuals
      | Visual Name                                              |
      | Late Recertifications Table                              |
      | Annual Recertification Line Chart                        |
      | Average Days to Completion Clustered Bar Chart           |
      | Annual Recertification Details Table                     |
      | Average Days to Completion: Rolling Prior 3 Years        |

    When the user deselects the selected row/column/record

    Then the table data should revert to its default state