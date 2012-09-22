FactoryGirl.define do

  factory :user do
    username { Faker::Internet.user_name }
  end

  factory :accomplishment do
    association :poster, :factory => :user
    association :receiver, :factory => :user
    association :scope, :factory => :scope
    description { Faker::Lorem.paragraph }
  end

  factory :scope do
    name { Faker::Name.name }
  end
end
