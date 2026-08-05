Background: 
    Given the dataset and modules are already deployed in both non-region and region environments, 
    And a custom report has been created from the dataset
	##Datasets and module names are just examples, use whatever is set up to work already. Module_Test can be a standin for any existing module.

  Scenario: Tag changes do not detach custom reports in non-region environment #Use SQL to set to no region if needed#
    Given a dataset "Commercial Model [region_na] [module_Test]" exists in the template workspace
    And a custom report is associated with the dataset
    When the dataset tag "module_Test" is modified in the non-region environment #in PowerBi find the dataset in the right template, and rename
	And with Postman set to MRI DSG Dev run Proxied -> Post Deploy Reports
	When that completes check SQL dbo.reports and find the custom report
    Then the custom report should remain associated with the dataset
    And the report.templatedatasetname property should be updated with the new tag value

  Scenario: Dataset renaming does not detach custom reports
    Given a dataset "Commercial Model [region_na] [module_Test]" exists in the template workspace
    And a custom report is associated with the dataset
    When the dataset "Commercial Model [region_na] [module_Test]" is renamed to "Comm Model [region_na] [module_Test]"
	And with Postman set to MRI DSG Dev run Proxied -> Post Deploy Reports
	When that completes check SQL dbo.reports and find the custom report
    Then the custom report should be detached
    And the report.templatedatasetname property should reflect the updated name

  Scenario: Adding a module to an existing dataset does not detach custom reports
    Given a dataset "Commercial Model [region_na]" exists in the template workspace
    And a custom report is associated with the dataset
    When a new module "module_New" is added to the dataset "Commercial Model [region_na]" #If there is an existing module the new one is added after an addition symbol. i.e. [module_ResidentialManagement+New]
	And with Postman set to MRI DSG Dev run Proxied -> Post Deploy Reports
	When that completes check SQL dbo.reports and find the custom report
    Then the custom report should remain associated with the dataset
    And the report.templatedatasetname property should reflect the new module name

  Scenario: Renaming a module does not detach custom reports
    Given a dataset "Commercial Model [region_na] [module_Test]" exists in the template workspace
    And a custom report is associated with the dataset
    When the module "module_Test" in the dataset "Commercial Model [region_na]" is renamed to "module_New"
    And with Postman set to MRI DSG Dev run Proxied -> Post Deploy Reports
	When that completes check SQL dbo.reports and find the custom report
	Then the custom report should remain associated with the dataset
    And the report.templatedatasetname property should reflect the new module name

  Scenario: Region environment deployment fails for same dataset name in the same region #If needed add a region in SQL#
    Given the datasets "Commercial Model [region_na] [module_Test1]" and "Commercial Model [region_na] [module_Test2]" exist in the same workspace
    When the datasets are deployed in the region environment
    Then the deployment should fail with the error message "The following datasets do not have unique names in the template workspace"