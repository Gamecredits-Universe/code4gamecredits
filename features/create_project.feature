Feature: An user can create a project, linked with GitHub or not.
  Scenario: Create a project simple project
    Given I'm logged in on GitHub as "seldon"

    When I visit the home page
    And I click on "Create a project"
    And I click on "Log in with GitHub"
    Then I should see "New project"

    When I fill "Name" with "Project Foo"
    And I fill "Description" with "The foo project"
    And I click on "Save"
    Then I should see "The project was created"
    And there should be a project "Project Foo"
    And the description of the project should be
      """
      The foo project
      """
    And the project should hold tips
    And the project single collaborators should be "seldon"
    And the project address label should be "peer4commit-1"
    And the project donation address should be the same as account "peer4commit-1"
    And I should be on the project page

  Scenario: Create a project without name
    Given I'm logged in on GitHub as "seldon"

    When I visit the home page
    And I click on "Create a project"
    And I click on "Log in with GitHub"
    Then I should see "New project"

    And I click on "Save"
    Then I should see "Please fix"
    And there should be no project

  Scenario: Create a project without name
    Given I'm logged in on GitHub as "seldon"

    When I visit the home page
    And I click on "Create a project"
    And I click on "Log in with GitHub"
    Then I should see "New project"

    And I click on "Save"
    Then I should see "Please fix"
    And there should be no project

  Scenario: Create a project linked to a GitHub project
    Given I'm logged in on GitHub as "seldon"

    When I visit the home page
    And I click on "Create a project"
    And I click on "Log in with GitHub"
    Then I should see "New project"

    When I fill "Name" with "Project Foo"
    And I fill "Description" with "The foo project"
    And I fill "GitHub URL" with "http://github.com/sigmike/peer4commit"
    And I click on "Save"
    Then I should see "The project was created"
    And there should be a project "Project Foo"
    And the GitHub name of the project should be "sigmike/peer4commit"
    And the project should hold tips
    And the project single collaborators should be "seldon"
