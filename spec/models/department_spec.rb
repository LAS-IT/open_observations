require 'spec_helper'

describe Department do
  context "Factories" do
    subject { FactoryGirl.build(:department) }
    it { should be_valid }
  end
  describe "Validations" do
    context "Name" do
      before(:each) do
        @program = FactoryGirl.create(:program)
        name = 'Computer Science'
        FactoryGirl.create(:department, name: name, program: program)
      end
      let(:program) { @program }
      context "Duplicate Entry Exists" do
        subject { FactoryGirl.build(:department, name: 'Computer Science', program: program) }
        it { should_not be_valid }
        it { should have_errors_on(:name).with_message('has already been taken') }
      end
      context "No duplicate entries exist" do
        subject { FactoryGirl.build(:department, name: 'Chemistry', program: program) }
        it { should be_valid }
        it { should_not have_errors_on(:name) }
      end
    end
  end
end
