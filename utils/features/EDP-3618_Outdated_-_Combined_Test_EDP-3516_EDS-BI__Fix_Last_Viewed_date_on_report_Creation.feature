#Other tests use this function. Most if not all these scenarios can be included in those tests

Given I'm logged into AIG Dev and I pick any report from the All items tabs click the ellpsis and Copy as new dashboard, naming it ZCopy of [Dashboard]
When I click file Save, and return to the ellipsis to Publish Draft
When I scroll to the bottom of the All items tabs
Then ZCopy of [Dashboard] should say Today in bold letters

And when I click Recent
Then ZCopy of [Dashboard] should appear at the top with a bold Today beneath it.

Given I'm logged into the Azure database for AIG Dev 
When I run SELECT TOP (1000) * FROM [dbo].[Report] order by  name desc
And copy the Id for ZCopy of [Dashboard]
And run SELECT TOP (1000) * FROM [dbo].[ReportActivityRecord] where reportid = '[[ID from last step]]'
Then at the right side it should have a current Timestamp for LastUpdatedDate (factoring in timezone)