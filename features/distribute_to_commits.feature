Feature: A project collaborator distribute to commit authors
  Background:
    Given a project "a"
    And the project collaborators are:
      | seldon  |
      | daneel  |
    And our fee is "0"
    And a deposit of "500"
    And the last known commit is "AAA"
    And a new commit "BBB" with parent "AAA"
    And a new commit "CCC" with parent "BBB"
    And the author of commit "BBB" is "yugo"
    And the message of commit "BBB" is "Tiny change"
    And the author of commit "CCC" is "gaal"

  @javascript
  Scenario:
    Given I'm logged in as "seldon"
    And I go to the project page
    And I click on "Edit project"
    And I uncheck "Automatically send 1% of the balance to each commit added to the default branch of the GitHub project"
    And I click on "Save"
    Then I should see "The project has been updated"

    When the new commits are read

    When I go to the project page
    And I click on "New distribution"
    And I type "commits" in the recipient field
    And I select the recipient "Authors of non rewarded commits"
    Then the distribution form should have these recipients:
      | recipient | origin                    | comment | amount |
      | yugo      | Commit BBB: Tiny change   |         |        |
      | gaal      | Commit CCC: Some changes  |         |        |

    And I fill the amount to "yugo" with "0.5"
    And I remove the recipient "gaal"
    And I click on "Save"

    Then I should see these distribution lines:
      | recipient | origin                    | address                   | amount | percentage |
      | yugo      | Commit BBB: Tiny change   |                           |    0.5 |        100 |
    And I should see "Total amount: 0.50 PPC"
    When I click on "Send email request to provide an address"
    Then I should see "Request sent"
    And there should be 1 email sent
    And an email should have been sent to "yugo@example.com"

    When the new commits are read

    When I go to the project page
    And I click on "New distribution"
    And I type "commits" in the recipient field
    And I select the recipient "Authors of non rewarded commits"
    Then the distribution form should have these recipients:
      | recipient | origin                    | comment | amount |
      | gaal      | Commit CCC: Some changes  |         |        |
