Given I access Agora Insights Gateway
And click Dashboards (if not the default landing page), and All Items
And click the + icon to add a new dashboard
And with Select a dataset selected pick any of the available options below, and click +Add at the bottom
When I drag anything from under the Data tab to the main dashboard
And under File select Save as
And name the report ZZTest
#The name should start with ZZ, as part of what is being tested is that the report is visable at the bottom of the list#
And Save
Then ZZTest should appear at the bottom of the list

#When I click Recent
#Then ZZTest should appear at the top of the recent list(We have removed the Recent tab)
#There is no recent tab we have removed that in all env

#Repeat test in mobile view to ensure the report is not cut off on a smaller screen. Right click on the screen, select Inspect, and select a phone to view as#