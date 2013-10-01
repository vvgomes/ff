FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
  end

  factory :accomplishment do
    association :poster, :factory => :user
    association :receiver, :factory => :user
    description { 'fixing the build!' }
  end

  factory :suggestion do
    association :sender, :factory => :user
    association :receiver, :factory => :user
    description { Faker::Lorem.paragraph }
  end

  factory :plus_one do
    association :accomplishment
    association :user
  end
end
