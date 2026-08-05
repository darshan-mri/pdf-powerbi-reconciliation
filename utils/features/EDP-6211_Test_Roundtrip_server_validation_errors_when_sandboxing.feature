Given I'm logged into AIG in an account with permission to edit onboarded clients
When I go to the Onboarding Configuration screen, right click the tab at the top of the browser and select Duplicate (or just open another tab with the same address)
And I switch the client id on only one of the Onboarding Configuration screen
And in the first onboarding screen I click the Edit icon at the top right and change the client description to Testing
And I click the checkmark to confirm and then hit save at the bottom
Then it should save the new description without any issue

When I return to the second Onboarding Configuration screen, ensuring it does not reload
And I follow the above instructions to change the description to Testing
And hit save
Then it should display an error about having a duplicate name

When I edit the name again and set it to Testing2, and I accept and save
Then it should save without an errors