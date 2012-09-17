FactoryGirl.define do

  factory :user do
    username { Faker::Internet.user_name }
  end

  factory :accomplishment do
    association :poster, :factory => :user
    association :receiver, :factory => :user
    association :group, :factory => :group
    description { Faker::Lorem.paragraph }
  end

  factory :group do
    name { Faker::Name.name }
  end
end