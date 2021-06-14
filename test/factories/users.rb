FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "factory_test#{n}" }
    sequence(:email) { |n| "factory_test#{n}@testing.com" }
    password {"passwordforfact0rytest"}
  end
end
