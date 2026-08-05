Given I am in AIG Dev, and I select All Reports
When I click the ellpsis and make a new dashboard, naming it [OC]Copy of [Dashboard] #In this case [ ] are the actual characters, not variables
Then I should get a warning saying names cannot contain [ or ]

When I try renaming it Copy of Dash[Test]board #Again actual characters
Then I should get a warning saying names cannot contain [ or ]

## No long applies -- When I try renaming it Copy of Dashboard v0001
## Then I should get a warning that the name cannot end with v followed by digits

When I rename it ZCopy of Dashboard
And it saves as draft
When I select Publish Draft from the ellpsis 
And try naming it [OC]ZCopy of Dashboard
Then I should get a warning saying names cannot contain [ or ]
And try naming it Z[Cop]y of Dashboard
Then I should get a warning saying names cannot contain [ or ]

#When I try renaming it ZCopy of Dash[Test]board 
#Then I should get a warning saying names cannot contain [ or ]
#When I try renaming it ZCopy of Dashboard v1
#Then I should get a warning that the name cannot end with v followed by digits