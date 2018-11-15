require 'spec_helper'

feature "Academic Programs" do
  context "Manager" do
    background do
      user = FactoryGirl.create(:user, :with_school)
      program = FactoryGirl.create(:program, title: 'US Diploma', school: user.school)
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
    context "Uniqueness" do
      scenario "I try to add a duplicate program" do
        visit new_program_path
        within('#new_program') do
          fill_in 'Program Title', with: 'US Diploma'
          click_button 'Save'
        end
        expect(page).to have_content 'Title has already been taken'
      end
    end
  end
end