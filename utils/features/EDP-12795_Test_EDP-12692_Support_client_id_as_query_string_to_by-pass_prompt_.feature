#Works as of May, confirm in July/August it is still relevant with changes to login

Feature: AIG Authentication via Welcome-Proxy using MRI Client ID
  I want to pass my MRI client ID via the URL query string
  So that I can skip the prompt and be signed into Agora Insights seamlessly



  Scenario: Accessing AIG via URL with mriClientId (top-level URL) https://qa-mriagorainsights.redmz.mrisoftware.com/?mriclientid=MRIQWEB
    Given the user opens the AIG top-level URL with a valid "mriClientId" query parameter
    When the page loads
    Then the user should not be prompted to enter the MRI Client ID
    And the user should be signed into MRIQWEB successfully

  Scenario: Accessing AIG via URL with mriClientId (deep-link URL) https://qa-mriagorainsights.redmz.mrisoftware.com/onboard-config?mriclientid=MRIQWEB
    Given the user opens a deep-link AIG URL with a valid "mriClientId" query parameter
    When the page loads 
    Then the user should not be prompted to enter the MRI Client ID
    And the user should be signed into MRIQWEB successfully  (Deep linked to onboard configuration for testing)
    
  Scenario: Confirming unable to change mriClientIds via link (top-level URL) https://qa-mriagorainsights.redmz.mrisoftware.com/?mriclientid=MRIQWEB
    Given the user has already logged in in the scenario above
    When the user visits a link with a different mriClientId https://qa-mriagorainsights.redmz.mrisoftware.com/?mriclientid=P123456
    Then the user should not be prompted to enter the MRI Client ID
    And the user should be returned to the main page of the originally accessed mriClientId

  Scenario: Accessing AIG via URL without mriClientId (top-level URL) https://qa-mriagorainsights.redmz.mrisoftware.com/
    Given the user opens the AIG top-level URL without the "mriClientId" query parameter
    When the page loads
    Then the user should be prompted to enter the MRI Client ID
	Then the user should enter MRIQWEB and login
    And the user should be signed into MRIQWEB using the provided client ID

  Scenario: Accessing AIG via URL without mriClientId (deep-link URL) https://qa-mriagorainsights.redmz.mrisoftware.com/onboard-config
    Given the user opens a deep-link AIG URL without the "mriClientId" query parameter
    When the page loads
    Then the user should be prompted to enter the MRI Client ID
	Then the user should enter MRIQWEB and login
    And the user should be signed into MRIQWEB using the provided client ID

  Scenario: Prompt pre-fills previously signed-in client ID from Welcome
    Given the user previously signed into Welcome with a client ID
    And the user opens an AIG URL without the "mriClientId" query parameter
    When the prompt appears
    Then the client ID input should be pre-filled with the last signed-in client ID

  Scenario: Prompt does not pre-fill client ID after Welcome sign-out
    Given the user signs out of Welcome
    And the user opens an AIG URL without the "mriClientId" query parameter
    When the prompt appears
    Then the client ID input should be empty

  Scenario: Prompt does not pre-fill client ID after browser is closed
    Given the user previously signed into Welcome with a client ID
    And the browser is closed and reopened
    And the user opens an AIG URL without the "mriClientId" query parameter
    When the prompt appears
    Then the client ID input should be empty