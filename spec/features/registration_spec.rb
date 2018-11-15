require 'spec_helper'
feature "Registering for the application" do
  scenario "I click the register button" do
    visit root_path
    click_link 'Register Your School'
    page.should have_css 'form#new_user'
  end 

  scenario "I complete the registration form" do
    visit root_path
    click_link 'Register Your School'
    within('form#new_user') do
      fill_in 'First Name', with: 'Nick'
      fill_in 'Last Name', with: 'Carraway'
      fill_in 'Email', with: 'ncarraway@prolearning.dev'
      fill_in 'Password', with: 'it was gatsby'
      fill_in 'Confirm Password', with: 'it was gatsby'
      fill_in 'School Name', with: 'West Egg Academy'
      fill_in 'Town', with: 'New York'
      select 'United States', from: 'Country'
      click_button 'Complete Registration'
    end
    expect(current_path).to eq dashboard_path
    expect(page).to have_content 'Welcome to ProLearning, Nick Carraway'
    expect(page).to have_content 'West Egg Academy'
    find('#teacher_code').text.should match /[A-Z0-9]{8}/
    find('#observer_code').text.should match /[A-Z0-9]{8}/
  end
end