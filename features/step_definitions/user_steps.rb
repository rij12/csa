Given(/^we have the following Users:$/) do |users| 
    User.create!(users.hashes)
end

When(/^I search for User "([^"]*)"$/) do |query|
    visit('/users')
    fill_in('query', with: query)
    click_button('Search')
end

When(/^I enter "([^"]*)" in the search field$/) do |query|
    visit('/users')
    fill_in('query', with: query)
    #ask('does that look right?')
end

Then(/^the results must be:$/) do |expected_results|
    sleep 0.5
    results = [['firstname','surname','email', 'grad_year']] +
      page.all('tr.data').map {|tr|
      [ tr.find('.firstname').text,
        tr.find('.surname').text,
        tr.find('.email').text,
        tr.find('.grad_year').text ]
    }
    expected_results.diff!(results)
end
