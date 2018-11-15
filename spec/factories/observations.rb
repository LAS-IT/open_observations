# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :observation do
    course 
    teacher 
    user 
    observed_on "2014-01-15"
    period "C"
    number_of_students 6
    observer_confidence false
    feedback ""
    factory :observation_with_interactions do
      ignore do
        first_minute 0
        interaction_count 5
      end
      after(:create) do |observation, evaluator|
        (evaluator.first_minute...evaluator.first_minute+evaluator.interaction_count).each do |minute|
          create(:interaction, observation: observation, minute: minute)
        end
      end
    end
  end
end
