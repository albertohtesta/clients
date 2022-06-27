# frozen_string_literal: true

FactoryBot.define do
  factory :account_follow_ups do
    follow_date { "2022-06-21" }
    description { "MyString" }
    account
  end
end
