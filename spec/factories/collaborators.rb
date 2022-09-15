# frozen_string_literal: true

FactoryBot.define do
  factory :collaborator do
    last_name { "MyString" }
    first_name { Faker::Name.name }
    email { Faker::Internet.email }
    uuid { Faker::Internet.uuid }
    position { "Software Engineer" }
    profile { "www.mystring.com" }
    nickname { "MyString" }
    category { "DEVELOPER" }
    role

    trait :developer do
      association :role, :developer
    end

    trait :manager do
      association :role, :manager
    end
  end
end
