# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interaction do
    observation 
    teacher "presenting" 
    students "listening"
    grouping "whole_group"
    topic "course_content"
    using_technology false
    on_task 1
    minute 1
    note ""
    factory :interaction_with_multiple_codes do
      teacher %w(circulating presenting)
      students %w(answering reading_writing)
    end
  end

end
