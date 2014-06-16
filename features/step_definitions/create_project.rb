
Then(/^there should be a project "(.*?)"$/) do |arg1|
  Project.pluck(:name).should include(arg1)
  @project = Project.where(name: arg1).first
end

Then(/^the description of the project should be$/) do |string|
  @project.description.should eq(string)
end

Then(/^I should be on the project page$/) do
  current_url.should eq(project_url(@project))
end

Then(/^there should be no project$/) do
  Project.all.should be_empty
end

Then(/^the GitHub name of the project should be "(.*?)"$/) do |arg1|
  @project.full_name.should eq(arg1)
end

Then(/^the project GitHub ID should be "(.*?)"$/) do |arg1|
  @project.github_id.should eq(arg1)
end

Then(/^the project single collaborators should be "(.*?)"$/) do |arg1|
  if arg1 =~ /@/
    @project.collaborators.map(&:user).map(&:email).should eq([arg1])
  else
    @project.collaborators.map(&:user).map(&:nickname).should eq([arg1])
  end
end

Then(/^the project address label should be "(.*?)"$/) do |arg1|
  @project.address_label.should eq(arg1)
end

Then(/^the project donation address should be the same as account "(.*?)"$/) do |arg1|
  @project.bitcoin_address.should eq(BitcoinDaemon.instance.get_addresses_by_account(arg1).first)
end

