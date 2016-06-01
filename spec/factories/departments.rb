FactoryGirl.define do

  factory :department do
    sequence(:name) { |n| "#{n.ordinalize} department" }
  end

end
