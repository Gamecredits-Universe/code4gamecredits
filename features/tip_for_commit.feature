Feature: On projects not holding tips, a tip is created for each new commit
  Scenario: A project not holding tips
    Given a project
    And the project does not hold tips
    And the project GitHub name is "foo/bar"
    And the commits on GitHub for project "foo/bar" are
      | sha | author |
      | 123 | bob    |
      | abc | alice  |
      | 333 | bob    |
    And our fee is "0"
    And a deposit of "500"
    Given a GitHub user "bob" who has set his address to "mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1"

    When the project tips are built from commits
    Then the project should have these tips:
      | commit | amount |
      | 123    | 5.0    |
      | abc    | 4.95   |
      | 333    | 4.9005 |

    When the tipper is started
    Then these amounts should have been sent from the account of the project:
      | address                            | amount |
      | mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1 | 9.9005 |

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

    When the tipper is started
    Then no coins should have been sent
