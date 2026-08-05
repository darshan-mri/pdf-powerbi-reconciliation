Feature: Commercial Occupancy - Visuals

  Scenario: Verify Commercial Occupancy report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial Occupancy" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Occupied area keycard          |
      | Future Leased area keycard     |
      | actual leased area keycard     |
      | Vacant area Keycard            |
      | Walt keycard                   |
      | # of Leases Expiring Keycard       |
      | # of Leases Expiring Keycard       |
      | Occupied unit/area/% bar graph |
      | Occupancy Details table        |
      | Absorption (sq.ft) line graph  |
      | Lease changes table            |