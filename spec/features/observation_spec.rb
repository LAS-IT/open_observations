require 'spec_helper'

feature "Observations" do
  context "Manager" do
    background do
      @user = FactoryGirl.create(:user, :with_school)
      @teacher = FactoryGirl.create(:teacher, school: @user.school)
      @program = FactoryGirl.create(:program, title: 'US Diploma', school: @user.school)
      @department = FactoryGirl.create(:department, name: 'English', program: @program)
      @course = FactoryGirl.create(:course, name: 'Intro to Learning', department: @department, teacher: @teacher)
      sign_in_as(@user)
    end

    scenario "Adds an Observation" do
      visit course_path(@course)
      click_link 'Add a new Observation'
      within('#new_observation') do
        fill_in 'Period', with: 'C'
        fill_in 'Number of Students', with: '6'
        click_button 'Save'
      end
      within('.content-subhead') do
        expect(page.text).to match(/\d{2} \w{3} 20\d{2} Observation/)
      end
      within('.action-button') do
        expect(page).to have_content 'Edit Observation'
      end
    end

  end
end