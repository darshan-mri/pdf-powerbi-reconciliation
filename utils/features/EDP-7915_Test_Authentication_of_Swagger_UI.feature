Feature:Authentication of Swagger UI in DEV
  
  ##### Information 1 :- To get the URL for swagger UI follow the below steps #####
  # Login to AIG with any client ID 
  # Inspect the page (Ctrl + Shift + I) and reload the page 
  # In network tab search for 'savechanges'
  # Navigate Savechanges -> Header -> In 'request URL' copy the base URL -> then search in new tab with '/swagger'
  # Request URL ==> 'https://dev-api-mriagorainsights.devtest.mrisoftware.com/swagger' - Get login information below
  
  ##### Information 2 :- To get the password follow the steps below #####
  # Open Azure Portal "https://portal.azure.com/" 
  # Open 'key vaults' and search "kv-aig-dev" (kv-aig-qa for QA environment) and open the link
  # Under objects open secret and open link 'Swagger--Credentials--Password'
  # Click the link under the current version which has enabled status
  # Click show the secret value then copy the value(this value is nothing but password)
  
  Scenario: 1 Authenticating with valid credencials
    Given I access to the swagger URL # "https://dev-api-mriagorainsights.devtest.mrisoftware.com/swagger/index.html"
    When I insert valid username # "agora-insights-gateway"
    And I insert valid Password and click sign in button # refer Information 2
    Then the page brought up will be the swagger home page
    
  Scenario: 2 Authenticating with invalid credencials
  # Repeat the Scenarion 1 with invalid credentials, the result should be stayed out of swagger home page