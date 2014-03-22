Given(/^I'm logged in as "(.*?)"$/) do |arg1|
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = {
    "info" => {
      "nickname" => arg1,
      "primary_email" => "#{arg1}@example.com",
      "verified_emails" => [],
    },
  }
  visit root_path
  click_on "Sign in"
  page.should have_content("Successfully authenticated")
end

Given(/^I go to the project page$/) do
  visit project_path(@project)
end

Given(/^I click on "(.*?)"$/) do |arg1|
  click_on(arg1)
end

Given(/^I check "(.*?)"$/) do |arg1|
  check(arg1)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content(arg1)
end

