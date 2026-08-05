Feature: Financial Portfolio Hub

  Scenario: Verify that YTD Variance visual data is dynamically changing for various selections
    Given the user logs into Power BI
    When the user selects the appropriate workspace
    And the user selects the Financial Portfolio Hub report
    Then the following <keycards> should be displayed with names suffixed with the <TimeFrame Filter> selected from the filter pane
      | TimeFrame    |
      | MTD          |
      | YTD          |
      | QTD          |
      | Rolling 12m  |
      
      | Keycards     |
      | Revenues     |
      | OpEx         |
      | NOI          |
      | Capex        |
      | Net Cashflow |
      | Debt Service |
      | Non-OpEx     |
      
    When the user clicks on the More Details link in the <keycards>
    Then the following <visuals> should be displayed without any NAN/NILL/NULL/Blank values
    And the names of the <visuals> should be prefixed with the combination of <keycards> name and <TimeFrame Filter> name
      | visuals                     |
      | Actuals vs STD. Budget Chart|
      | Actual vs STD. Budget Table |
      | Variance Chart              |