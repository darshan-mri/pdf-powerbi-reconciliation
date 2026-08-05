Feature: B&F Financial Details
Scenario Outline: User opens the B&F Financial Details report and verifies that visuals load correctly with the specified format
    Given User logs into PowerBI
    And User selects the workspace
    When User opens the B&F Financial Details report
    Then The report should load without breaking any of the following <Visuals> with the <Format>

    Examples:
      | Visuals                                              | Format                            |
      | As of date = MM/YY                                   | MM/YY                             |
      | Updated date details                                 | m/dd/yyyy HH:MM:SS AM/PM Timezone |
      | Blended Forecast:Actuals table                       |                                  |
      | Variance Details:Actuals table                       |                                  |
      | Blended Forecast Details:Actuals table               |                                  |
      | Ask agora                                            |                                  |