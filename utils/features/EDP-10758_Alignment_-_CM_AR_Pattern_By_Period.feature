Feature: Residential AR Pattern By Pattern

  Scenario: User views report visuals without breakage and with proper alignment
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then The user should be able to see all visuals without any breakage
    And All the visuals' titles and text should be properly aligned