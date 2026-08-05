##Needs to be reevaluated for changes with Ask Agora and DeeDee

Feature: Ask Agora dashboards reload correctly when switching between clients

  Background:
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com" as MRIQWEB clientID

  Scenario: Ask Agora reports load correctly for each client after switching

    # Step 1: Setup for client MRIQWEB
    Given I select the client with ID "MRIQWEB"
    When I click on the "Ask Agora" widget
    Then I should be navigated to the Ask Agora dashboards page
    And if no reports are visible
      Then I open the "DeployTest" workspace in Power BI
      And I rename the reports using the format "Any Report [category_AskAgora|Test|Demo]" You can use any string after category for testing purpose, make atleast 2 to 3 Ask Agora reports to validate
      And I deploy the Deploy Test template either from UI or via Postman,Change the parametres in dev env include templateworkspaceID as Deploy Test and send the deploy reports request
    Then I should see the MRIQWEB-specific reports load in the Ask Agora dashboard once deployment complete

    # Step 2: Setup for client p123456
    When I switch to the client with ID "p123456"
    And I click on the "Ask Agora" widget
    Then I should be navigated to the Ask Agora dashboards page
    And if no reports are visible
    #Follow above process for deploying the reports of different reports with different category names
    # Step 3: Validate dashboard switching
    When I switch back to the client with ID "MRIQWEB"
    Then I should see only the MRIQWEB-specific reports loads correctly in the Ask Agora dashboard

    When I switch back to the client with ID "p123456"
    Then I should see only the p123456-specific reports loads in the Ask Agora dashboard