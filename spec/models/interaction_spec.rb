require 'spec_helper'

describe Interaction do
  describe 'Factories' do
    context 'Basic Factory' do
      subject { FactoryGirl.build(:interaction) }
      it { should be_valid }
    end
    context 'Multiple Codes Factory' do
      subject { FactoryGirl.build(:interaction_with_multiple_codes)}
      it { should be_valid }
    end
  end
  describe 'Single Code Strings' do
    subject { FactoryGirl.build(:interaction) }
    it "has a P Teacher Code" do
      subject.teacher_code.should eq 'P'
    end
    it "has a L Students Code" do
      subject.students_code.should eq 'L'
    end
    it "has a w Grouping Code" do
      subject.grouping_code.should eq 'w'
    end
    it "has a cc Topic Code" do
      subject.topic_code.should eq 'cc'
    end
    it "has a PLwcc Code String" do
      subject.code_string.should eq 'PLwcc'
    end
  end
  describe 'Full Code Strings' do
    subject { FactoryGirl.build(:interaction_with_multiple_codes) }
    it "has a PC full Teacher Code" do
      subject.teacher_code(full: true).should eq 'PC'
    end
    it "has a P typical Teacher Code" do
      subject.teacher_code.should eq 'P'
    end
    it "has a ARW full Students Code" do
      subject.students_code(full: true).should eq 'ARW'
    end
    it "has a A typical Students Code" do
      subject.students_code.should eq 'A'
    end
  end
end
