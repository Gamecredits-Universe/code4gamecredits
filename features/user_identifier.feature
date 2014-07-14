Feature: Each user has an unique identifier
  Scenario: New email user gets an unique identifier
    When I visit the home page
    And I click on "Sign in"
    And I click on "Sign up"
    And I fill "Email" with "bob@example.com"
    And I fill "Password" with "password"
    And I fill "Password confirmation" with "password"
    And I click on "Sign up"
    Then I should see "confirmation link"

    And an email should have been sent to "bob@example.com"
    When I click on "Confirm my account" in the email
    Then I should see "confirmed"

    And I fill "Email" with "bob@example.com"
    And I fill "Password" with "password"
    And I click on "Sign in" in the sign in form
    When I go to edit my profile
    Then I should see the identifier of "bob@example.com"
