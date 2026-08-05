Feature: Residential Lease Expiration - Filter Options and Dynamic Updates

  Scenario: User interacts with filters and sees dynamic updates based on the selections
    Given User logs into Power BI
    And User selects the workspace
    When User opens the report
    And clicks on the Filter show/hide pane
    Then The following <filters> options should be displayed:
      | Filters                 |  
      | Date 				            |
      | Portfolio 		          |
      | Entity Type 		        |
      | Life Code 		          |
      | Property Type 	        |
      | Property Sub Type       |
      | Class ID 			          |
      | Investment Flag 	      |
      | Investment Type 	      |
      | Location ID 		        |
      | State ID 			          |
      | Unit Type 		          |
      | Owner 			            |
      | Asset Manager 	        |
      | Department 	          	|
      | Property Manager	      |
      | Unit 				            |
      | Resident Name 	        |
      | Regional Manager 	      |
      | Bed and Bath	 	        |
      | Charge Codes		        |
      | Building ID - Name      |
      | Property ID - Name      |
      | Project ID - Name	      |
      | IsActiveProperty	      |
      | Agent                   |
      
    And The following <filter> options should have default selections:
      | Date                  | Current Date      |
      | IsActiveProperty      | true              |
    And The <filter> options should update dynamically based on the selections made
    And The visuals should display relevant data based on the selected filter conditions
    And The Residential Lease Expiration details should be accurately reflected based on the filter selections