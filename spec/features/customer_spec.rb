require 'rails_helper'

RSpec.describe 'the signout process', :type => :feature do
  it 'signs me out' do
    with_customer_signed_in
    visit "/customers/#{@customer.id}"
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on("Logout #{@customer.email}")
    expect(page).to have_content 'Signed out successfully'
  end
end

RSpec.describe 'the signin process', :type => :feature do
  it 'signs me in' do
    with_customer_signed_in
    expect(page).to have_content 'Signed in successfully.'
  end
end

RSpec.describe 'the work request creation process', :type => :feature do
  it 'directs to new work request form' do 
    create :service_category, name: 'paint'
    with_customer_signed_in
    find_link('New Work Request').click()
    expect(page).to have_content 'Enter Work Request'
    within('#new_customer_request') do
      fill_in 'customer_request[address]', with: '2418 central park ave' 
      fill_in 'customer_request[city]', with: 'chicago' 
      fill_in 'customer_request[state]', with: 'illinois'
      fill_in 'customer_request[zipcode]', with: '60647'
      fill_in 'customer_request[description]', with: 'abc'
      fill_in 'customer_request[expires_date]', with: Date.today + 1
      select('paint', from: 'customer_request[service_category_id]')
      click_button 'Submit'
    end 
    expect(page).to have_content 'My Work Requests'
  end
end

def with_customer_signed_in
  @customer = create :customer, email: 'customer@example.com', password: 'password'
  visit '/customers/sign_in'
  within('.login-form') do
    fill_in 'customer[email]', with: 'customer@example.com'
    fill_in 'customer[password]', with: 'password'
  end
  click_button 'Log in'
end