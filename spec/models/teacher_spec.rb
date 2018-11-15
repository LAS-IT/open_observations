require 'spec_helper'

describe Teacher do
  describe "Factories" do
    context "Basic Factory" do
      subject { FactoryGirl.create(:teacher) }
      it { should be_valid }
    end
    context "With User" do
      subject { FactoryGirl.create(:teacher, :with_user) }
      it { should be_valid }
    end
  end
end
