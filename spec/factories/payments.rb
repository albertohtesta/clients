# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    payment_date { "2022-06-14 13:44:34" }
    cut_off_date { "2022-06-14" }
    payday_limit { "2022-06-14" }
    account
  end
end
