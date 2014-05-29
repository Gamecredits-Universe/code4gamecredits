Feature: Project detailed description is markdown formatted
  Scenario:
    Given a project
    And the project single collaborator is "bob"
    And I'm logged in as "bob"
    And I go to the project page
    And I click on "Edit project"
    And I fill "Detailed description" with:
      """
      foo [bar](http://foo.example.com/)
      """
    And I click on "Save"
    Then I should see a link "bar" to "http://foo.example.com/"

