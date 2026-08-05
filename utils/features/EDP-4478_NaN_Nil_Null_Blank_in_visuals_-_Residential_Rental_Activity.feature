Feature: NaN/Nil/Null/Blank in visuals - Residential Rental Activity
  Scenario: Verify that NaN/Null/Nil/Blank Values are not displayed in Residential Rental Activity report
    Given User logs into Power BI
    And User selects the workspace
    When User opens the Residential Rental Activity report
    Then NaN/Null/Nil/Blank values should not be displayed in any of the visuals