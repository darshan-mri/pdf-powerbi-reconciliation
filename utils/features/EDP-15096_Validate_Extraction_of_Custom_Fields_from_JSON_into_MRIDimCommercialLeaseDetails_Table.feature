Feature: Custom Fields Extraction from JSON to MRIDimCommercialLeases Table

  Scenario: Validate extraction and availability of all custom fields from JSON blob
    Given User logs into PowerBI
    And User opens the dataset containing MRIDimCommercialLeases table

    When the data model is refreshed after updating the partition logic
    Then all fields from the CustomFields JSON blob should be extracted successfully

    And the table should contain the following new columns:
      | SALESYEARSTART |
      | PERSQUAREFOOT |
      | SquareFootTypeId |
      | WEIGHTEDAVERAGESQAUREFOOTAGE |
      | LEASEDSquareFeet |
      | SALESSTARTMONTH |
      | SALESYEARENDMONTH |
      | SALESYEAREND |
      | SALESAMOUNT |
      | NAME |
      | ACTUALSuiteId |
      | Period |
      | SUITSquareFeet |
      | SquareFeet |
      | ACTUALPSQFT |
      | BREAKPOINT |

    And text fields should contain valid string values or nulls
    And numeric fields should contain valid numeric values or nulls
    And no extraction errors should occur for non-null JSON records

    And the refreshed data model should display populated values for extracted fields in reports