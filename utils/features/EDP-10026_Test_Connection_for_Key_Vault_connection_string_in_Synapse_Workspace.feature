Scenario: Test Connection for Key Vault connection string in Synapse Workspace
    Given the key vault has been created for the customer
    When user opens the Synapse workspace and navigates to Manage and then Linked services
    And user searchs for PMXSourceConnections and opens it
    And user clicks Test Connection and provides the created keyVaultConnectionString
    Then the connection test should pass