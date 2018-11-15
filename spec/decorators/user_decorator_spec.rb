require 'spec_helper'

describe UserDecorator do
  subject { user.decorate }
  let(:user) { FactoryGirl.build(:user, first_name: 'Daisy', last_name: 'Buchanan') }
  it "displays a users full name" do
    subject.full_name.should eq 'Daisy Buchanan'    
  end
end
