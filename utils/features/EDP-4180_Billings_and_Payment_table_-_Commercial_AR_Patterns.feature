Feature: Commercial AR Patterns

  Scenario: Display and interact with Billings and Payment table data based on selected reporting range
    Given the user is logged into Power BI
    And the user has selected the workspace
    When the user opens the report
    Then the user should be able to see the title name suffixed with the selected Reporting Range
    And the table with headers and proper data should be loaded
      | ------Headers-------|
      | Month & Year        |
      | Master Occupant     |
      | Occupant & Lease ID |
      | Aged Billings       |
      | Aged Credits        |
      | Aged Open Charges   |
    And the table values should be sorted in descending order based on Master Occupant Grouping Column
    When the user selects any of the records from the table
    Then the information related to the selected record should be displayed in key cards and other visuals