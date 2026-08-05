Feature: Table Visual UI Validation

  Scenario: Validate table styling and formatting
    Given User logs into Power BI
    When User opens the Financial/Commercial/Residential report from the workspace
    Then Header font should be Segoe UI 10pt color #162029
    And Column headers should have background color #FFFFFF
    And Header bottom border should be 1px solid #404D66
    And Table values should use Segoe UI 10pt color #162029
    And Alternating rows should have background #F1F1F1
    And Total row should have top border 1px solid #404D66
    And Visual background should be ON with color #FFFFFF
    And Visual border should be ON with 8px radius and color #F1F4F6
    And Padding inside visual should be 16px