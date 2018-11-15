require 'spec_helper'

feature "Academic Programs" do
  context "Manager" do
    background do
      user = FactoryGirl.create(:user, :with_school)
      user.add_role :manager
      sign_in_as(user)
    end

    scenario "I want to add a program" do
      visit programs_path
      click_link 'Add an Academic Program'
      within('#new_program') do
        fill_in 'Program Title', with: 'International Baccalaureate'
        click_button 'Save'
      end
      expect(current_path).to eq programs_path
    end
  end
end