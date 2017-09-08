require 'rails_helper'

Rspec.describe 'Clicking the home button', :type => :feature do
  visit '/about'
  find_link('Home').click
  expect(page).to have_content 'Connect Customers in Need with Veterans in Skilled Trades'
end