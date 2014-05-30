
Given(/^a GitHub user "(.*?)" who has set his address to "(.*?)"$/) do |arg1, arg2|
  create(:user, email: "#{arg1}@example.com", nickname: arg1, bitcoin_address: arg2)
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
  within "#recipients tr", text: arg1, exact: true do
    fill_in "Amount", with: arg2
  end
end

Then(/^I should see these distribution lines:$/) do |table|
  table.hashes.each do |row|
    tr = find("#distribution-show-page tr", text: row["recipient"])
    tr.find(".recipient").should have_content(row["recipient"])
    tr.find(".address").should have_content(row["address"])
    tr.find(".amount").should have_content(row["amount"])
    tr.find(".percentage").should have_content(row["percentage"])
  end
end

Then(/^these amounts should have been sent from the account of the project:$/) do |table|
  BitcoinDaemon.instance.list_transactions(@project.address_label).map do |tx|
    if tx["category"] == "send"
      {
        "address" => tx["address"],
        "amount" => (-tx["amount"]).to_s,
      }
    end
  end.compact.should eq(table.hashes)
end

When(/^the tipper is started$/) do
  BitcoinTipper.work
end

Then(/^no coins should have been sent$/) do
  BitcoinDaemon.instance.list_transactions("*").should eq([])
end

