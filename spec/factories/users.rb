FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user_##{n}@test.com" }
    first_name 'First'
    last_name 'Last'
  end

end
