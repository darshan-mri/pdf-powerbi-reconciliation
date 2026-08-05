Scenario: Delete icon triggers confirmation popup
  Given I am on the Plugin Screen, User Management, Client Management, Key-Value Pair Query, or Query Connector page
  When I click on the "Delete" icon for a record
  Then a confirmation popup should appear asking the user to confirm the deletion

Scenario: Cancel or X closes confirmation popup without deleting
  Given the delete confirmation popup is open
  When I click on the "Cancel" button or the "X" icon
  Then the popup should close
  And the record should not be deleted

Scenario: Confirming deletion removes record from UI and sets IsDeleted in DB
  Given the delete confirmation popup is open
  When I click on the "Delete" button
  Then the selected record should be removed from the UI grid
  And the "IsDeleted" column for that record in the database should be set to 1