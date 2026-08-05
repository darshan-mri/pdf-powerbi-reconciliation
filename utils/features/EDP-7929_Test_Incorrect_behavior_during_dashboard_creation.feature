Feature: Incorrect behavior of dashboard creation
  
  Scenario: A draft not created by double clicking 'create dashboard' button.
    Given Access to AIG web application 
    When I open 'Commercial AR Insights' # any report is fine
    And on right side top click elipses (...) and click copy as new dashboard
    And double click the 'Create dashboard' button
    And on right side top click elipses (...) and click discard
    Then The draft shouln't be created