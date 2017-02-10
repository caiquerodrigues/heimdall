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

    trait :iamheimdall do
      name 'Heimdall'
      surname 'God'
      email 'iamheimdall@local.com'
      password 'godmode'
      password_confirmation 'godmode'
      role 'admin'
    end
  end
end
