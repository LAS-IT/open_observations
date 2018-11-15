require 'spec_helper'

describe Observation do
  describe 'Factories' do
    context 'Basic Factories' do
      subject { FactoryGirl.build(:observation) }
      it { should be_valid }
    end
  end
  context 'A Completed Observation' do
    subject { FactoryGirl.create(:observation_with_interactions, interaction_count: 40) }
    it 'has 40 interactions' do
      expect(subject.interactions.count).to eq 40
    end
    it 'returns true for #observation_recorded?' do
      expect(subject.observation_recorded?).to be true
    end
    it 'changes #observer_confidence to true with #confident!' do
      expect { subject.confident! }.to change{subject.observer_confidence?}.from(false).to(true)
    end
    it 'changes #observer_confidence to false with #not_confident!' do
      subject.confident!
      expect { subject.not_confident! }.to change{subject.observer_confidence?}.from(true).to(false)
    end
  end
  context 'An incomplete observation' do
    subject { FactoryGirl.create(:observation_with_interactions, interaction_count: 20) }
    it 'is not recorded' do
      expect(subject.observation_recorded?).to be false      
    end
    it 'adds an error to #observer_confidence if attempted to mark as confident' do
      subject.confident!
      expect(subject).to have_errors_on(:observer_confidence).with_message('cannot be true for an incomplete observation') 
    end
  end
end
