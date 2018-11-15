require 'spec_helper'

describe Focus do
  describe 'Factories' do
    context 'Basic Factory' do
      subject { FactoryGirl.build(:focus) }
      it { should be_valid }
    end
  end
end
