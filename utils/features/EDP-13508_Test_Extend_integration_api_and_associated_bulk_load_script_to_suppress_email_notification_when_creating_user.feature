##Note: This ideally is run from the folder which contains all the AIG data-services-gateway material. This can be run from any folder (and can be useful to test just for that). Instructions will differentiate between the two methods.##

Given I want to test the federation of new users
When I go to script folder ( data-services-gateway/tools/infrastructure/ps-functions or a custom folder)
And I open the Invoke-AppUserUpdate.ps1 in Notepad
And scroll down to the section 
##
begin {
        Set-StrictMode -Version 'Latest'
        $callerEA = $ErrorActionPreference
        $ErrorActionPreference = 'Stop'
        . "$PSScriptRoot/Get-AigApiHeaders.ps1"
        . "$PSScriptRoot/Get-ClientCredentialAccessToken.ps1"
##
Then the two paths at the bottom should point to the correct folder, either the default PSScriptRoot folder or the custom folder (i.e. C:\Scripttesting)



When I create a users.csv with the three headers FirstName, LastName, UserName
And I populate it with test data
##Note: UserName is email. For ease of testing if you use gmail or another service that allows sub-addresses, you can use the same email with different sub-addresses thisismyname+testing@gmail.com (thisismyname@gmail.com being the normal email +testing allows it to be treated as a different email)
If an email has already been tested with this, then later on in the testing it will return the error message saving Validation Failed. Found invalid record(s)
##
And save it to the same path used above, default or custom
Then users.csv should now exist with the scripts in the folder



When I open up a PowerShell (Core/7) 
And navigate to the folder with the scripts
And define the variables below making sure the csvPath is the correct folder, and to include the secret (These can be entered all at once or individually)

##
$csvPath = "C:\Scripttesting\users.csv"

$clientId = "0oa1qzle2sfRrZdBi0h8"
$clientSecret = "REPLACEWITHREALSECRET" | ConvertTo-SecureString -AsPlainText -Force
$clientCredential = [PSCredential]::new($clientId, $clientSecret)

$baseUrl = "https://qa-api-mriagorainsights.devtest.mrisoftware.com"
$tokenUrl = "https://mrisaas.oktapreview.com/oauth2/aus1eysxsrq3e974M0h8/v1/token"

$mriClientId = "P123456"
##

##: USE INT not DSG. INT!
Note: If this seems to be causing an error then confirm the addresses, Id and secret, all of which are available in Postman MRI AIG Int – dev in the variables section, match the required value with the correct Postman field
clientId is tokenClientId in postman
clientSecret can be found by going to tokenClientSecret, and following the azure link (easier to navigate than the oktalink), if there is a value, not a url there it might be the current secret, but it is easier to reset that field and follow the url to confirm the Secret
baseUrl is just baseUrl in postman
tokenUrl is tokenIssuerUrl with this added at the end of the url /v1/token
##
Then there should be no errors displayed after the values are defined in PowerShell.



When I load the function into PowerShell by entering
##
. "C:\Scripttesting\Invoke-AppUserUpdate.ps1"
##
##Note: that line starts with a period then a space before the quotation mark and path, the period and space are required
##
Then no errors should be displayed
##Note: If you receive an error indicating the ? in the script is a problem you are running an old version of powershell and should be running Powershell 7



When I run the function below to test the users.csv is being read correctly
##
Import-Csv $csvPath | Select-Object -First 5
| ##
Then it should display the top five items in that csv



When I run the function without federation by putting the below in PowerShell
##
Invoke-AppUserUpdate -CsvFilePath $csvPath -ClientCredential $clientCredential -BaseUrl $baseUrl -TokenUrl $tokenUrl -MriClientId $mriClientId -InfA Continue -EA Continue
##
Then an email should be sent to the username addresses to continue the account setup. If more than five addresses are in the users.csv there will be a pause before the normal PowerShell prompt returns, the system will pause for 30 seconds every 5 users.
And if I check https://mrisaas-admin.oktapreview.com/ for those usernames
Then they will appear saying ‘Pending User Action’
##Note: If an error about not being digitally signed appears you can temporarily bypass that with the below line in PowerShell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
This will only bypass that requirement in that specific PowerShell window##
##Note: If an error about Validation failed. Found invalid record(s) appears it means an email in the list is already existent in okta and you need to update the users.csv to remove that address, you can check okta like in the test above##
##Note: It makes sense to test without federation first and that provides feedback that all the variables are correct when the confirmation email is successfully sent. With federation no email is sent so to confirm the variables are correct you need to manually check the account in okta##



When I change the sub-addresses of some emails in the users.csv 
And run the function with federation by using the below in PowerShell

Invoke-AppUserUpdate -CsvFilePath $csvPath -ClientCredential $clientCredential -BaseUrl $baseUrl -TokenUrl $tokenUrl -MriClientId $mriClientId -InfA Continue -EA Continue -Federated

##Note: -Federated at the end is the only difference in how these are called##
Then the screen should show no errors or messages, no emails will be sent, and checking https://mrisaas-admin.oktapreview.com/ searching the username can find that account is now active