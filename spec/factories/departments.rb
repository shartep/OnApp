FactoryGirl.define do

  factory :department do
    name 'Main department'
  end

  factory :invalid_department, class: :department do
    name Array.new(10, 'Name longer then 255 chars').join(', ')
  end

end
