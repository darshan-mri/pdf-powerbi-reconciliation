Feature: NaN/Nill/Null/Blank Values - AH Compliance Certifications
  Scenario: Ensure NaN/Nil/Null/Blank values are handled appropriately
    Given the user is logged into Power BI
    And the user selects the appropriate workspace
    When the user opens the "AH Compliance Certifications" report
    Then the report should load without breaking any visuals
    And NaN/Null/Nil/Blank values should not be displayed in any of the visuals