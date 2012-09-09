FactoryGirl.define do

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Name.name }
  end
  
  factory :accomplishment do
    association :poster, :factory => :user
    association :receiver, :factory => :user
    description { Faker::Lorem.paragraph }
  end

end