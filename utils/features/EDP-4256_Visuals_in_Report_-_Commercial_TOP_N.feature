Feature: Commercial Top N - Visuals

  Scenario: Verify Commercial TOP N report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial TOP N" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Top (N) Criteria                        |
      | Lease End Date                          |
      | TOP (N) Grouping                        |
      | Lease Expiration Bar graph              |
      | Top N Details Table                     |
      | Top N Criteria TextBox                  |
      | Top N Grouping Bar graph                |
      | Total Square Foot textBox               |
      | Total Sq.Ft and Rent PSF Scatter chart  |