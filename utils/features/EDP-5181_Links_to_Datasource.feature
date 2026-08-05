#Note: Other tests use this function, remove and include in them

Given I am logged into AIG
When I access a report and click the Link button near the top right
And decide to navigate to either the Datasource (Data model) or Version workspace
Then I should be brought to that workspace (though may be told I do not have permission to view it)