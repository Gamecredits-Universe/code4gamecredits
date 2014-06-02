
Given(/^a GitHub user "(.*?)" who has set his address to "(.*?)"$/) do |arg1, arg2|
  create(:user, email: "#{arg1}@example.com", nickname: arg1, bitcoin_address: arg2)
end

Given(/^a GitHub user "([^"]*?)"$/) do |arg1|
  create(:user, email: "#{arg1}@example.com", nickname: arg1, bitcoin_address: nil)
end

Given(/^an user with email "(.*?)"$/) do |arg1|
  create(:user, email: arg1, nickname: nil, bitcoin_address: nil)
end

Given(/^I type "(.*?)" in the recipient field$/) do |arg1|
  fill_in "add-recipients-input", with: arg1
end

Given(/^I select the recipient "(.*?)"$/) do |arg1|
  within "#recipient-suggestions" do
    click_on arg1
  end
end

Given(/^I fill the amount to "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  within "#recipients tr", text: /^#{Regexp.escape arg1}/ do
    fill_in "Amount", with: arg2
  end
end

Given(/^I fill the comment to "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  within "#recipients tr", text: /^#{Regexp.escape arg1}/ do
    fill_in "Comment", with: arg2
  end
end

When(/^I remove the recipient "(.*?)"$/) do |arg1|
  within "#recipients tr", text: /^#{Regexp.escape arg1}/ do
    check "Remove"
  end
end

Then(/^I should see these distribution lines:$/) do |table|
  table.hashes.each do |row|
    begin
      tr = find("#distribution-show-page tbody tr", text: row["recipient"])
    rescue
      puts "Rows: " + all("#distribution-show-page tbody tr").map(&:text).inspect
      raise
    end
    tr.find(".recipient").text.should eq(row["recipient"])
    tr.find(".address").text.should eq(row["address"]) if row["address"]
    tr.find(".origin").text.should eq(row["origin"]) if row["origin"]
    if row["amount"]
      text = tr.find(".amount").text
      if row["amount"] =~ /\A[0-9.]+\Z/
        text.to_d.should eq(row["amount"].to_d)
      else
        text.should eq(row["amount"])
      end
    end
    if row["percentage"]
      text = tr.find(".percentage").text
      if row["percentage"] =~ /\A[0-9.]+\Z/
        text.to_d.should eq(row["percentage"].to_d)
      else
        text.should eq(row["percentage"])
      end
    end
    tr.find(".comment").text.should eq(row["comment"]) if row["comment"]
  end
  table.hashes.size.should eq(all("#distribution-show-page tbody tr").size)
end

Then(/^the distribution form should have these recipients:$/) do |table|
  table.hashes.each do |row|
    begin
      tr = find("#distribution-form #recipients tr", text: row["recipient"])
    rescue
      puts "Rows: " + all("#distribution-form #recipients tr").map(&:text).inspect
      raise
    end
    tr.find(".recipient").text.should eq(row["recipient"])
    tr.find(".origin").text.should eq(row["origin"]) if row["origin"]
    if row["amount"]
      text = tr.find_field("Amount").value
      if row["amount"] =~ /\A[0-9.]+\Z/
        text.to_d.should eq(row["amount"].to_d)
      else
        text.should eq(row["amount"])
      end
    end
    if row["comment"]
      text = tr.find_field("Comment").value
      text.should eq(row["comment"])
    end
  end
  all("#distribution-form tbody tr").size.should eq(table.hashes.size)
end

When(/^the tipper is started$/) do
  BitcoinTipper.work
end

Then(/^no coins should have been sent$/) do
  BitcoinDaemon.instance.list_transactions("*").should eq([])
end

When(/^I set my address to "(.*?)"$/) do |arg1|
  step 'I go to edit my profile'
  fill_in "Peercoin address", with: arg1
  fill_in "Current password", with: "password"
  click_on "Update"
  page.should have_content "You updated your account successfully"
end

When(/^I click on the last distribution$/) do
  find("#distribution-list .distribution-link:first-child").click
end

Then(/^an email should have been sent to "(.*?)"$/) do |arg1|
  ActionMailer::Base.deliveries.map(&:to).should include([arg1])
  @email = ActionMailer::Base.deliveries.detect { |email| email.to == [arg1] }
end

Then(/^the email should include "(.*?)"$/) do |arg1|
  @email.body.should include(arg1)
end

Then(/^the email should include a link to the last distribution$/) do
  distribution = Distribution.last
  @email.body.should include(project_distribution_url(distribution.project, distribution))
end

When(/^I visit the link to set my password and address from the email$/) do
  step "I click on the \"Set your password and Peercoin address\" link in the email"
end

Then(/^the user with email "(.*?)" should have "(.*?)" as password$/) do |arg1, arg2|
  User.find_by(email: arg1).valid_password?(arg2).should eq(true)
end

Then(/^the user with email "(.*?)" should have "(.*?)" as peercoin address$/) do |arg1, arg2|
  User.find_by(email: arg1).bitcoin_address.should eq(arg2)
end

