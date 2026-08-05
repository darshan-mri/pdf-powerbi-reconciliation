Feature: Commercial Rent Roll

  Scenario: User accesses the User guide
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the User guide link
    Then the User guide for the corresponding report should be loaded properly as a PDF or document