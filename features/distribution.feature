Feature: Fundraisers can distribute funds
  @javascript
  Scenario:
    Given a GitHub user "bob" who has set his address to "mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1"

    Given a project managed by "alice"
    And our fee is "0"
    And a deposit of "500"

    Given I'm logged in as "alice"
    And I go to the project page
    And I click on "New distribution"
    And I type "bob" in the recipient field
    And I select the recipient "bob (GitHub user)"
    And I fill the amount to "bob (GitHub user)" with "10"
    And I click on "Save"

    Then I should see these distribution lines:
      | recipient         | address                            | amount | percentage |
      | bob (GitHub user) | mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1 |     10 |        100 |
    And I should see "Total amount: 10.00 PPC"

    When the tipper is started
    Then no coins should have been sent

    When I click on "Send the transaction"
    Then these amounts should have been sent from the account of the project:
      | address                            | amount |
      | mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1 |   10.0 |
    And the project balance should be "490"
    And I should see "Sent"

  @javascript
  Scenario: Send distribution to multiple users
    Given a GitHub user "bob" who has set his address to "mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1"
    And a GitHub user "carol" who has set his address to "mi9SLroAgc8eUNuLwnZmdyqWdShbNtvr3n"

    Given a project managed by "alice"
    And our fee is "0"
    And a deposit of "500"

    Given I'm logged in as "alice"
    And I go to the project page
    And I click on "New distribution"
    And I type "bob" in the recipient field
    And I select the recipient "bob (GitHub user)"
    And I fill the amount to "bob (GitHub user)" with "10"
    And I type "carol" in the recipient field
    And I select the recipient "carol (GitHub user)"
    And I fill the amount to "carol (GitHub user)" with "13.56"
    And I click on "Save"

    Then I should see these distribution lines:
      | recipient           | address                            | amount | percentage |
      | bob (GitHub user)   | mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1 |     10 |       42.4 |
      | carol (GitHub user) | mi9SLroAgc8eUNuLwnZmdyqWdShbNtvr3n |  13.56 |       57.6 |
    And I should see "Total amount: 23.56 PPC"

    When the tipper is started
    Then no coins should have been sent

    When I click on "Send the transaction"
    Then these amounts should have been sent from the account of the project:
      | address                            | amount |
      | mxWfjaZJTNN5QKeZZYQ5HW3vgALFBsnuG1 |   10.0 |
      | mi9SLroAgc8eUNuLwnZmdyqWdShbNtvr3n |  13.56 |
    And the project balance should be "476.44"
    And I should see "Sent"

  Scenario: Send to an user without address
