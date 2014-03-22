Feature: A project collaborator can change the tips of commits
  Background:
    Given a project
    And the project collaborators are:
      | seldon  |
      | daneel  |
    And our fee is "0"
    And a deposit of "500"
    And the last known commit is "A"
    And a new commit "B" with parent "A"
    And the author of commit "B" is "yugo"

  Scenario: Without anything modified
    When the new commits are read
    Then there should be a tip of "5" for commit "B"
    And there should be 1 email sent

  Scenario: A collaborator wants to alter the tips
    Given I'm logged in as "seldon"
    And I go to the project page
    And I click on "Change project settings"
    And I check "Do not send the tips immediatly. Give collaborators the ability to modify the tips before they're sent"
    And I click on "Save the project settings"
    Then I should see "The project settings have been updated"

    When the new commits are read
    Then the tip amount for commit "B" should be undecided
    And there should be 0 email sent

