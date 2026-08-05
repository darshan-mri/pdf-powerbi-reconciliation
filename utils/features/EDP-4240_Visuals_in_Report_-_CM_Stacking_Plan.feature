Feature: Commercial Stacking Plan - Visuals

  Scenario: Verify Financial NOI Analysis report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial Stacking Plan" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Building Selector Drop down   |
      | Total Units keycard           |
      | Vacant Units Keycard          |
      | Year 1 Unit kaycard           |
      | Year 2 Unit kaycard           |
      | Year 3 Unit kaycard           |
      | Year 4+ Unit kaycard          |
      | Holdover/MTM Keycard          |
      | Stacking Plan - Occupied area |
      | Stacking Plan - equal spacing |
      | Stacking Plan Table           |
      | Vacant Units Bar Graph        |
      | Year 1 Unit Bar Graph         |
      | Year 2 Unit Bar Graph         |
      | Year 3 Unit Bar Graph         |
      | Year 4+ Unit Bar Graph        |
      | Holdover/MTM Bar graph        |
      | Unit Inforation Pie Chart     |