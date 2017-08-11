Given(/^we are on page "([^"]*)"$/) do |arg1|
  visit(arg1)
end

When(/^I click on the Users tab$/) do
  click_link('Users')
end

Then(/^it should be highlighted$/) do
  expect(page.html).to include("<a class=\"selected\" href=\"/users\">")
end
