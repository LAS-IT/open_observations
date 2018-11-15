# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "Introduction to English"
    description "An introductory course"
    section "C"
    semester "First"
    teacher 
    department 
  end
end
