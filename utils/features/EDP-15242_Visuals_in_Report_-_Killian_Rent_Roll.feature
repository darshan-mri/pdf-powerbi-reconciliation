Feature: Killian Rent Roll - Visuals

  Scenario: Verify Killian Rent Roll report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Killian Rent Roll" report from the workspace
    Then the report should load without breaking any of the following visuals:                    |
      | Building ID - Name               |
      | Occupant Name                    | 
      | Occupied Area Keycard            | 
      | Future Leased Area Keycard       |
      | Actual Leased Area Keycard       |
      | Vacant Area Keycard              |
      | Current Charges                  |
      | Escalations                      |
      | Options                          |