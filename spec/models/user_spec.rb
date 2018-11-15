require 'spec_helper'
require 'cancan/matchers'

describe User do
  context "Factories" do
    describe "The Basic Factory" do
      subject { FactoryGirl.build(:user) }
      it { should be_valid }
    end
    describe "With a School" do
      subject { FactoryGirl.build(:user, :with_school) }
      it { should be_valid }
      it "associates a school object with a user" do
        expect(subject.school).to be_present        
      end
    end
  end
  describe "Abilities for Manager" do
    subject { Ability.new(user) }
    let(:user) { nil }
    context "own self" do
      before(:each) do
        @me = FactoryGirl.create(:user)
        @not_me = FactoryGirl.create(:user)
      end
      let(:user) { @me }
      let(:someone_else) { @note_me }
      it "can read self" do
        expect(subject).to be_able_to(:read, user) 
      end
      it "can update self" do
        expect(subject).to be_able_to(:update, user) 
      end
      it "cannot read someone else" do
        expect(subject).to_not be_able_to(:read, someone_else)
      end
      it "cannot update someone else" do
        expect(subject).to_not be_able_to(:update, someone_else)
      end
      it "cannot delete users" do
        expect(subject).to_not be_able_to(:delete, User)
      end
    end
    context "own school" do
      before(:all) do
        @me = FactoryGirl.create(:user, :with_school)
        @another_school = FactoryGirl.create(:school)
      end
      let(:user) { @me }
      let(:my_school) { user.school }
      let(:not_my_school) { @another_school }
      it "can manage school" do
        expect(subject).to be_able_to(:manage, user.school)
      end
      it "cannot manage another school" do
        expect(subject).to_not be_able_to(:manage, not_my_school)
      end
      it "cannot delete any school" do
        expect(subject).to_not be_able_to(:delete, School.new)
      end
    end
    context "own school's programs" do
      before(:all) do
        @me = FactoryGirl.create(:user, :with_school)
        @program = FactoryGirl.create(:program, school: @me.school)
        @other_program = FactoryGirl.create(:program)
      end
      let(:user) { @me }
      let(:schools_program) { @program }
      let(:other_schools_program) { @other_program }
      it "can create programs" do
        expect(subject).to be_able_to(:create, Program) 
      end
      it "can manage programs from own school" do
        expect(subject).to be_able_to(:manage, schools_program)
      end
      it "cannot manage programs from another school" do
        expect(subject).to_not be_able_to(:manage, other_schools_program)
      end
    end
  end
end
