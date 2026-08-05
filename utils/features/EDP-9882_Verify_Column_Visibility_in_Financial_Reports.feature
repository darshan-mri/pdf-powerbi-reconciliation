Scenario: User interacts with Financial Reports and edits columns visibility
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