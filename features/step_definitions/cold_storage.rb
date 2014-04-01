Given(/^the cold storage addresses are$/) do |table|
  CONFIG["cold_storage"] ||= {}
  CONFIG["cold_storage"]["addresses"] = table.raw.map(&:first)
end

Given(/^the project address is "(.*?)"$/) do |arg1|
  @project.update(bitcoin_address: arg1)
end

Given(/^the project cold storage withdrawal address is "(.*?)"$/) do |arg1|
  @project.update(cold_storage_withdrawal_address: arg1)
end

When(/^there's a new incoming transaction of "([^"]*?)" on the project account$/) do |arg1|
  PeercoinDaemon.instance.add_transaction(account: @project.address_label, amount: arg1.to_d)
end

When(/^there's a new incoming transaction of "(.*?)" to address "(.*?)" on the project account$/) do |arg1, arg2|
  PeercoinDaemon.instance.add_transaction(account: @project.address_label, amount: arg1.to_d, address: arg2)
end

When(/^there's a new incoming transaction of "(.*?)" to address "(.*?)" on the project account with (\d+) confirmations$/) do |arg1, arg2, arg3|
  PeercoinDaemon.instance.add_transaction(account: @project.address_label, amount: arg1.to_d, address: arg2, confirmations: arg3.to_i)
end

When(/^there's a new outgoing transaction of "(.*?)" to address "(.*?)" on the project account$/) do |arg1, arg2|
  PeercoinDaemon.instance.add_transaction(category: "send", account: @project.address_label, amount: -arg1.to_d, address: arg2)
end

When(/^there's a new outgoing transaction of "(.*?)" to address "(.*?)" on the project account with (\d+) confirmations$/) do |arg1, arg2, arg3|
  PeercoinDaemon.instance.add_transaction(category: "send", account: @project.address_label, amount: -arg1.to_d, address: arg2, confirmations: arg3.to_i)
end

When(/^the project balance is updated$/) do
  PeercoinBalanceUpdater.work
end

Then(/^updating the project balance should raise an error$/) do
  expect { PeercoinBalanceUpdater.work }.to raise_error
end

Then(/^the project balance should be "(.*?)"$/) do |arg1|
  (@project.reload.available_amount.to_d / COIN).should eq(arg1.to_d)
end

Then(/^the project amount in cold storage should be "(.*?)"$/) do |arg1|
  (@project.reload.cold_storage_amount / COIN).should eq(arg1.to_d)
end

When(/^"(.*?)" peercoins of the project funds are sent to cold storage$/) do |arg1|
  @project.send_to_cold_storage!((arg1.to_d * COIN).to_i)
end

Then(/^there should be an outgoing transaction of "(.*?)" to address "(.*?)" on the project account$/) do |arg1, arg2|
  transactions = PeercoinDaemon.instance.list_transactions(@project.address_label)
  transactions.map { |t| t["category"] }.should eq(["send"])
  transactions.map { |t| t["address"] }.should eq([arg2])
  transactions.map { |t| -t["amount"].to_d / COIN }.should eq([arg1.to_d])
end

Given(/^the project has no cold storage withdrawal address$/) do
  @project.update(cold_storage_withdrawal_address: nil)
end

Then(/^the project should have a cold storage withdrawal address$/) do
  @project.reload.cold_storage_withdrawal_address.should_not be_blank
end

Then(/^the project cold storage withdrawal address should be linked to its account$/) do
  PeercoinDaemon.instance.get_addresses_by_account(@project.address_label).should include(@project.reload.cold_storage_withdrawal_address)
end

