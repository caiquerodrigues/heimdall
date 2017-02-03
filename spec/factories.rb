FactoryGirl.define do
  factory :account do
    trait :full do
      name 'Admin'
      surname 'Heimdall'
      sequence(:email){ |n| "admin#{n}@heimdall.local" }
      password 'good'
      password_confirmation 'good'
      role 'admin'
    end
  end
end
