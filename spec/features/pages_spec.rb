require 'rails_helper'

RSpec.describe 'Clicking navbar links', :type => :feature do

  it 'goes to the homepage' do
    visit '/about'
    find_link('Home').click
    expect(page).to have_content 'Connect Customers in Need with Veterans in Skilled Trades'
  end

  it 'goes to the how page' do
    visit '/'
    find_link('How').click
    expect(page).to have_content 'How It Works:'
  end


end