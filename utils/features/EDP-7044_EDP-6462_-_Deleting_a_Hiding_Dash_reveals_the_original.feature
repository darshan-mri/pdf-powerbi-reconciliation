Given I'm logged into AIG with an account that can create dashboard
When I go view any dashboard, and in the top-right click the ellipsis and select Copy as New Dashboard
And I name it HidingDash, I click and remove a few visuals from the dash so it can be told apart from the original
And I click save, and then at the top-right Publish the draft
When asked if it is a new dash or a hiding/replacement dash use it to hide the original dashboard
And then in SQL delete the new dash
##Delete from [dbo].[report] where Name = 'HidingDash'
When I refresh AIG the new dashboard will be gone and the original will be viewable again