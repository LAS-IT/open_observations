FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password 'a1b2c3d4e5'
    password_confirmation'a1b2c3d4e5'
    trait :with_school do
      school 
    end
  end
end