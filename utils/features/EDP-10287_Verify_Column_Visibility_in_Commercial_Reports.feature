Feature: Commercial Data Model
Scenario: User interacts with Commercial Reports and edits columns visibility
    Given User logs into PowerBI
    When User selects the workspace
    And User opens Financial reports
    Then The user should be able to see all the visuals without any breakage
    When User moves to the edit mode by clicking on the edit button
    Then The User should be able to see the following columns in any of the tables, and all the below columns should be hidden:
      | MRIClientID    |
      | CreatedDate    |
      | UpdatedDate    |
      | IsCurrentRow   |
      | SK Columns     |
    And Search for 'Test' in Data Section
    Then test Measures should be hidden and not visible to the user