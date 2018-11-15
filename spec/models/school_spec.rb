require 'spec_helper'

describe School do
  describe "Factories" do
    context "It has a valid default factory" do
      subject { FactoryGirl.build(:school) }
      it { should be_valid }
    end
  end
  describe "Generated Attributes" do
    subject { FactoryGirl.build(:school) }
    context "generates before validation" do
      it "calls #generate_code" do
        expect(subject).to receive(:generate_code)
        subject.valid?
      end
    end
    context "#teacher_code" do
      it "is an 8 character of capital letters and numbers" do
        expect(subject.teacher_code).to match(/^[A-Z0-9]{8}$/)
      end
    end
    context "#observer_code" do
      it "is an 8 character of capital letters and numbers" do
        expect(subject.observer_code).to match(/^[A-Z0-9]{8}$/)
      end
    end
  end
end
