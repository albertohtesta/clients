# frozen_string_literal: true

FactoryBot.define do
  factory :account_status do
    status_code { Faker::Name.name }
    status { Faker::Name.name }
  end
end
