When(/^I choose the amount "(.*?)" on commit "(.*?)"$/) do |arg1, arg2|
  within find("tr", text: arg2) do
    choose arg1
  end
end
