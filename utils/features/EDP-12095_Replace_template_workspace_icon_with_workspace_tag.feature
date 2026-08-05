Feature: Workspace labels and badges

  Background:
    Given I am logged into "https://dev-mriagorainsights.redmz.mrisoftware.com/" as client "MRIQWEB"
    And I have permission to edit and publish dashboards

  Scenario: Workspace icons are replaced by labels/badges
    When I navigate to the dashboards page
    Then I should see labels or badges instead of workspace icons

  Scenario: No UI breakages after label/badge update
    When I navigate through the dashboards management, and client onboard pages
    Then all UI components should display correctly without errors

  Scenario: Labels/badges are not shown when there is a single workspace
    Given the environment has single template workspaces
    When I open the workspace filter
    Then labels or badges should not be shown

  Scenario: Labels/badges are shown when there are multiple workspaces
    Given the environment has multiple template workspaces
    When I open the workspace filter
    Then labels or badges should be shown

  Scenario: Legacy behavior — filter shows labels/badges regardless of count
    Given the workspace filter mode is "legacy"
    And the environment has single template workspaces
    When I open the workspace filter
    Then labels or badges should be shown