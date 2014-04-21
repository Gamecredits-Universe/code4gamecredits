Feature: A commit with an identified GitHub nickname should be sent to the right user if he exists
  Scenario:
    Given a project "a"
    And our fee is "0"
    And a deposit of "500"
    And an user "yugo"
    And the email of "yugo" is "yugo1@example.com"
    And the last known commit is "A"
    And a new commit "B" with parent "A"
    And the author of commit "B" is "yugo"
    And the email of commit "B" is "yugo2@example.com"

    When the new commits are read
    Then there should be a tip of "5" for commit "B"
    And the tip for commit "B" is for user "yugo"
    And there should be no user with email "yugo2@example.com"
