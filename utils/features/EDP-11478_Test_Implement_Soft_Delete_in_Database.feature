Feature: Soft Delete functionality for system tables

  Background:
    Given the application is connected to the database

  Scenario Outline: Soft delete a record from <Users> and verify Is_Deleted column is set to 1
    Given a record exists in the <Users> table with Is_Deleted = 0
    When I perform a delete operation on the record in the <Users> table
    Then the Is_Deleted column for that record should be updated to 1
    And the record should not appear in the default (non-deleted) record query

    Examples:
      | TableName         |
      | Users             |
      | Client            |
      | Roles             |
      | ClientQuery       |
      | QueryConnector    |
      | Screens           |