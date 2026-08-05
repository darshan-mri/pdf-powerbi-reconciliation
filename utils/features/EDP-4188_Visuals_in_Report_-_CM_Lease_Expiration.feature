Feature: Commercial Lease Expiration - Visual
  
  Scenario: Verify Commercial Lease Expiration report loads correctly without breaking visuals
    Given the user logs into PowerBI
    When the user opens the "Commercial Lease Expiration" report from the workspace
    Then the report should load without breaking any of the following visuals:
      | Lease Expiration Units Line Graph   |
      | Lease Details Table                 |
      | Expiry Bandings Pie chart           |