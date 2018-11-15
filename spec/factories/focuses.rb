# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :focus do
    name "Direct Formative Assessment"
    active true
    school
  end
end
