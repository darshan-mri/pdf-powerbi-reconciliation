Feature: Card Designer page

Scenario: Verify import is not allowed without mandatory fields

  Given the user is on the "Card Designer" page
  When the user clicks on the "Import" button 
  Then the "Import Screen" Panel should be visible
  Then validation error messages should be displayed for mandatory fields
  And the "Name" field should show "This field is required"
  And the "Description" field should show "This field is required"
  And the "Import button should not be visible"