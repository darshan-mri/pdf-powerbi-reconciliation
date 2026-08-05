Given I'm logged into the AIG Dev environment, ClientId P123456 (https://dev-mriagorainsights.redmz.mrisoftware.com/)
When I go to All items and find a report with a draft version (Commercial Occ v2 works is currently setup for this)
And I click the ellipsis, and click the draft
Then the report should regenerate to the draft

When I click the browser's back button
Then the report should regenerate