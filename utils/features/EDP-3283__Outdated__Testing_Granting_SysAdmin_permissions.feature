Given I am already a System admin and signed into AIG 
When I assign the System admin role to another user that has the MRIQWEB assigned to their profile in okta, ##MRIQWEB must be assigned, regardless of what clientid is being used for granting system admin access to
Then the change should be successful

Given I am already a System admin and signed into AIG, 
When I assign the System admin rule to another user that does not have the MRIQWEB assigned to their profile in okta, 
Then the change should fail with a validation message explaining the issue available as a tooltip next to the System Admin checkbox

Given an refused attempt at assigning System Admin role, 
When pressing the cancel button 
Then the validation message should clear