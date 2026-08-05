Feature: Commercial Rent Roll - Visuals

  Scenario: Verify Financial NOI Analysis report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial Rent Roll" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Total Units                    |
      | Occupied Units                 |
      | Reserved units                 | 
      | Vacant units                   | 
      | annual rent bar graph          |
      | Rent roll table                |
      | Total sq.mt keycard            |
      | Monthly rent keycard           |
      | Annual Rent keycard            |
      | Annuam Rent PSM keycard        |
      | Monthly Cost Recovery keycard  |
      | Monthly Other income keycard   |