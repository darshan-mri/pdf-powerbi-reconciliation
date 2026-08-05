Feature: Card Designer - Create Card (Background Option)

  Scenario: Verify creation of a new card using Background option

    Given the user is logged in as an "Admin"
    And the user is on the "Card Designer" page
    When the user clicks on the "+ Add" button
    Then the "Create New Card" panel should be displayed
    And the user selects the "Background" tab
    Then the "Background" section should display the following fields:
      | Field                |
      | Background           |
      | Background Image     |
      | Background Image Size|
      | Opacity              |
    When the user selects a background type from "Background" dropdown
    Then the following behavior should be applied:
      | Background Type | Expected Behavior                                      |
      | None            | No additional fields should be displayed               |
      | Image           | Background Image, Image Size, and Opacity should show  |
      | Colour          | Background Colour and Opacity fields should show       |
    When the user uploads a valid background image (for Image option)
    Then the image should be accepted successfully
    And if the uploaded file format is invalid
    Then an appropriate validation error message should be displayed
    When the user enters valid data in all required fields
    Then the "Next" button should be enabled
    When the user clicks on the "Next" button
    Then the user should be redirected to the "Card Designing" page