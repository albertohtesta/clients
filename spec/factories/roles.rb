# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { "MyString" }

    trait :developer do
      name { "Developer" }
    end

    trait :manager do
      name { "Account Manager" }
    end

    trait :admin do
      name { "admin" }
    end
  end
end
