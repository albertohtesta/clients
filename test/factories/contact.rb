# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    first_name { "First name" }
    email { "email@email.com" }
    account
  end
end
