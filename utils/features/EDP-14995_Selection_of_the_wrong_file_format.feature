Feature:Card Designer
  
  Scenario:Choosing of the wrong file format to import the cards
    
    Given the user logged in as Admin
    And the user is in the "Card Designer" page
    When the user clicks on the"Import" button 
    Then the "import Screen" panel should be displayed
    When the user clicks on the "Choose file" button
    Then the window should be opend which enable us to select the files which are in the "Json" format
    When the user selects the file other than json format then the valid error message should be displayed