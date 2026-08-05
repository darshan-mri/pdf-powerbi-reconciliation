Feature: Recertifications Due - AH Annual Certifications

  Scenario: User interacts with the "Recertifications Due" KeyCard
    Given the user is logged into Power BI
    And the user opens the "AH Annual Certifications" report from the appropriate Workspace
    Then all visuals in the report should load without any breakage
    And by default, the title of the KeyCard should be "Recertifications Due - Next 90 Days"
    And the KeyCard should display the following time ranges:
      | Next 90 Days   |
      | 0 - 30 Days    |
      | 31 - 60 Days   |
      | 61 - 90 Days   |

    Then the "Next 90 Days" KeyCard visual should be formatted as a callout in the Visualizations pane
    And the following KeyCard visuals should be formatted as reference labels in the Visualizations pane:
      | 0 - 30 Days     |
      | 31 - 60 Days    |
      | 61 - 90 Days    |

    And if any values are blank, they should be represented as '--'