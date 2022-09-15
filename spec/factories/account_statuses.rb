# frozen_string_literal: true

FactoryBot.define do
  factory :account_status do
    status_code { "my_string" }
    status { "MyString" }
  end
end
