Scenario: Validate handling null and default values in transformations

Given some source fields may contain null or blank values
When the data is transformed and loaded
Then null values should be handled as defined (e.g., replaced with defaults or ignored or loaded as is) in both Fact and Dimension tables
And default values should be applied correctly where configured