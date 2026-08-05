Feature: Residential AR Insights

  Scenario: Verifying slicer period selection and data display
    Given User logs into Power BI
    And User selects the workspace
    When the User opens the report
    Then the default slicer period should be set to 30 days
    When the user selects any of the ranges from the chiclet slicer
    Then the data corresponding to the selected range should be displayed in key cards and other visuals