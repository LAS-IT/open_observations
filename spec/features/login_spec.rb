require 'spec_helper'
feature "During the login process", type: :feature do
  background do 
    @user = FactoryGirl.create(:user, :with_school, email: 'user@prolearning.dev', password: 'a1b2c3d4e5', password_confirmation: 'a1b2c3d4e5')
  end

  scenario "I sign into the application" do
    sign_in_as(@user)
    expect(current_path).to eq dashboard_path
  end
end