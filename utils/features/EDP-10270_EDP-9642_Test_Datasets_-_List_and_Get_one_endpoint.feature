Feature: delsPbiDataset API Endpoints
  
  ##See bottom for notes on API and variable names

  Scenario 1: List all datasets for an app (Multiple Workspaces)
    Given the API request is authenticated as a service principal
    When I send a GET request to "api/internal/pbidatasets" (Pbi Workspaces - current-refs)
    Then the response status should be 200
    And the response should contain a list of active datasets

  Scenario 2: List all datasets for a user (Multiple Workspaces)
    Given I am impersonating user "{{currentUsername}}"
    When I send a GET request to "api/internal/users/{{currentUsername}}/pbidatasets"
    Then the response status should be 200
    And the response should contain a list of active datasets

  Scenario 3: List datasets for an app in a single workspace
    Given the API request is authenticated as a service principal
    When I send a GET request to "api/internal/workspaces/{{templateWorkspaceIdOrName}}/pbidatasets   ((Removed this suffix as it caused issues))?workspaceQualifier={{workspaceQualifier}}"
    Then the response status should be 200
    And the response should contain datasets in the specified workspace

  Scenario 4: List datasets for a user in a single workspace
    Given I am impersonating user "{{currentUsername}}"
    When I send a GET request to "api/internal/users/{{currentUsername}}/workspaces/{{templateWorkspaceIdOrName}}/pbidatasets?{"orderBy": ["Name desc"], "skip":0, "take":200, "inlineCount": true}  ((Removed suffix due to issue))&workspaceQualifier=primary"
    Then the response status should be 200
    And the response should contain datasets in the specified workspace

  Scenario 5: Retrieve a specific dataset for an app
    Given the API request is authenticated as a service principal
    When I send a GET request to "api/internal/workspaces/{{templateWorkspaceIdOrName}}/pbidatasets/{{pbiDatasetIdOrName}}?{"orderBy": ["Name desc"], "skip":0, "take":200, "inlineCount": true}&workspaceQualifier=primary"
    Then the response status should be 200
    And the response should contain dataset details for "{{pbiDatasetIdOrName}}"

  Scenario 6: Retrieve a specific dataset for a user
    Given I am impersonating user "{{currentUsername}}"
    When I send a GET request to "api/internal/users/{{currentUsername}}/workspaces/{{templateWorkspaceIdOrName}}/pbidatasets/{{pbiDatasetIdOrName}}?{"orderBy": ["Name desc"], "skip":0, "take":200, "inlineCount": true}
    Then the response status should be 200
    And the response should contain dataset details for "{{pbiDatasetIdOrName}}"

  Scenario 7: Validate unauthorized access
    Given I am not authenticated
    When I send a GET request to any delsPbiDataset endpoint
    Then the response status should be 401

  Scenario 8: Validate permission handling for users
    Given I am impersonating user "{{currentUsername}}"
    And the user does not have permission to see the dataset
    When I send a GET request to "api/internal/users/{{currentUsername}}/pbidatasets"
    Then the response status should be 403




##Use api/internal/pbidatasets and copy an entry to get example of below variables

##{pbiDatasetIdOrName} = ID 
##{templateWorkspaceIdOrName} = "templateWorkspaceId"