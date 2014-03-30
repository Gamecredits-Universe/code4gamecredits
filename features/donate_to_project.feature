Feature: A visitor can donate to a project
  Scenario: A visitor sends coins to a project
    Given a project
    And our fee is "0.01"

    When I visit the project page
    Then I should see the project donation address

    Given there's a new incoming transaction of "50" on the project account
    And the project balance is updated

    When I visit the project page
    Then I should see the project balance is "49.5"

