Feature:Card Designer
  Scenario:Importing of the cards
    
    Given the user logged in as Admin
    And the user is in the "Card Designer"
    When the user clicks on the "Import" Button
    Then the "import Screen" side panel should be displayed
    And the following fields must be visible
    |select file|
    | Name|
    | Description|
    When all the fields are filled 
    Then the import button should be enabled