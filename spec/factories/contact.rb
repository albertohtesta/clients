# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    salesforce_id { "Id" }
    phone { "23345234" }
    account
    last_name { "MyString" }
    first_name { Faker::Name.name }
    email { Faker::Internet.email }
    uuid { Faker::Internet.uuid }

    trait :user do
      association :account, :user
    end
  end
end
