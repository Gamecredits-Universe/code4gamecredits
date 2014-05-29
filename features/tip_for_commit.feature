Feature: On projects not holding tips, a tip is created for each new commit
  Scenario: A project not holding tips
    Given a project
    And the project does not hold tips
    And the project GitHub name is "foo/bar"
    And the commits on GitHub for project "foo/bar" are
      | sha |
      | 123 |
      | abc |
      | 333 |
    And our fee is "0"
    And a deposit of "500"

    When the project tips are built from commits
    Then the project should have these tips:
      | commit | amount |
      | 123    | 5.0    |
      | abc    | 4.95   |
      | 333    | 4.9005 |

  Scenario: A project holding tips
    Given a project
    And the project holds tips
    And the project GitHub name is "foo/bar"
    And the commits on GitHub for project "foo/bar" are
      | sha |
      | 123 |
      | abc |
      | 333 |
    And our fee is "0"
    And a deposit of "500"

    When the project tips are built from commits
    Then the project should have these tips:
      | commit | amount |
      | 123    |        |
      | abc    |        |
      | 333    |        |
