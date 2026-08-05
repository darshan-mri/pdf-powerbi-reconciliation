Feature: Annual Recertification chart and Certification Load table Data Consistency - AH Annual Certifcations
  Scenario: Ensure that the total count displayed in the 'Annual Recertification' chart matches the total count shown in the 'Certification Load' table
   
  Given the user is logged into Power BI
  And the user has selected the appropriate workspace
  When the user opens the "AH Annual Certifications" report
  Then the 'Annual Recertification' chart and 'Certification Load' table should be visible
  And the value in the upper-right corner of the 'Annual Recertification' chart should match the total in the 'Certification Load' table