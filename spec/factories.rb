FactoryGirl.define do

  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { Faker::Name.name }
  end
  
  factory :accomplishment do
    association :poster, :factory => :user
    association :receiver, :factory => :user
    description { Faker::Lorem.paragraph }
  end

end