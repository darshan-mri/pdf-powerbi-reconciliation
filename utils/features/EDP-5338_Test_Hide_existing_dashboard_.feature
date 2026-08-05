Given I am logged into AIG
When I click All items, below Dashboards, and pick any report
And click the ellipsis at the top right selecting Copy as new dashboard
And I rename it ZCopy of [Report] (may have to remove the square brackets around region if displayed)
And Create dashboard
Then the new ZCopy report will be made as a draft

When I click a visual, and delete it
And click Save at the top left
And then Publish Draft from the ellipsis
And select New Dashboard, and Publish Dashboard
Then the new ZCopy report will be an active dashboard

When still in ZCopy report I click the ellipsis, Copy as new dashboard
And name it ZZCopy
And I click on a visual, and delete it (noting which one is removed)
And click Save at the top left
And then Publish Draft from the ellipsis
And select Replacement Dashboard
And select ZCopy (if not automatically selected)
And click Publish Dashboard
Then there should no longer be a ZZCopy on the dashboard panel, and the new ZCopy should have the above deleted visual missing (proving it did replace the original ZCopy), and clicking the Wrench icon on the left side of the screen to open Dashboard Access ZZCopy should not appear on the list of reports nor any indication of a hidden report