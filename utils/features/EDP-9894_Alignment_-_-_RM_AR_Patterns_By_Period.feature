Feature: Residential AR Pattern By Period
  
  Scenario: Viewing All Visuals Without Breakage and Proper Alignment
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    Then User should be able to see all visuals without any breakage
    And All the visual titles and texts should be properly aligned