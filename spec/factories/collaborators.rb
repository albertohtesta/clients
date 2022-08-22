# frozen_string_literal: true

FactoryBot.define do
  factory :collaborator do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    uuid { "MyString" }
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
