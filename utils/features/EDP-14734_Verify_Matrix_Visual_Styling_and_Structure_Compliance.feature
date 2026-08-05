Feature: Matrix Visual UI Validation

  Scenario: Validate matrix styling
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Title should be Segoe UI 18pt color #404D66
    And Column headers should be Segoe UI 10pt color #162029
    And Header background should be #FFFFFF
    And Values should have alternating row color #F1F1F1
    And Subtotals should have top border 1px solid #404D66
    And Background should be ON with color #FFFFFF
    And Visual border should be 8px radius color #F1F4F6
    And Padding should be 16px