Feature: Get Roles API

  Scenario: Fetch all the roles successfully
    Given the API endpoint "/aiaw-api/Role/GetRole" is available
    And the base URL is "https://dev-apiga-mriagorainsightsanywhere.devtest.mrisoftware.com"
    When I send a GET request to the endpoint
    Then the response status code should be 200
    And the response should contain a list of roles