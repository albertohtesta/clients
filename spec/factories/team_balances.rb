# frozen_string_literal: true

FactoryBot.define do
  factory :team_balance do
    balance { 1.5 }
    balance_date { "2022-08-17" }
    team_id { 1 }
    account_id { 1 }
  end
end
