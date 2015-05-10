Then(/^I should see the identifier of "(.*?)"$/) do |arg1|
  identifier = User.find_by(email: arg1).identifier
  identifier.should be_present
  page.should have_content identifier
end
