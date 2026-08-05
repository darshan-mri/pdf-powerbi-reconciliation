Given I am logged into my OktaPreview account, and log into https://dev-mriagorainsights.redmz.mrisoftware.com/ client MRIQWEB
When I go to Dashboard Management, Groups will be selected by default
When I click Add Item and name the group TestDuplicate
And I click Add Item again and also name the second group TestDuplicate 
Then an error should appear saying the name must be unique and the Create button will be disabled

When I click Add Item again and also name the second group TESTDUPLICATE 
Then an error should appear saying the name must be unique and the Create button will be disabled