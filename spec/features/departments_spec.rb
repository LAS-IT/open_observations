require 'spec_helper'

feature "Departments" do
  context "Manager" do
    background do
      @user = FactoryGirl.create(:user, :with_school)
      @program = FactoryGirl.create(:program, title: 'US Diploma', school: @user.school)
      sign_in_as(@user)
    end

    scenario "I want to add a department (picking the program)" do
      visit departments_path
      click_link 'Add a new Department'
      within('#new_department') do
        select 'US Diploma', from: 'department_program_id'
        fill_in 'Department Name', with: 'Computer Science'
        click_button 'Save'
      end
      expect(current_path).to eq departments_path
      within('#departments') do
        expect(page).to have_content 'Computer Science'
      end
    end
    context "Editing an Existing Department" do
      background do
        @department = FactoryGirl.create(:department, name: 'Computer Science', program: @program)
      end
      scenario "I can edit an existing department" do
        visit edit_department_path(@department)
        within("#edit_department_#{@department.id}") do
          fill_in 'Department Name', with: 'CS'
          click_button 'Save'
        end
        within("h2.content-subhead") do
          expect(page).to have_content 'CS'
        end
      end
    end
  end
end