require 'spec_helper'

describe Course do
  describe 'Factories' do
    context 'Basic Factory' do
      subject { FactoryGirl.build(:course) }
      it { should be_valid }
    end
  end
end
