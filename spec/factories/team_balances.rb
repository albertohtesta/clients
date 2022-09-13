# frozen_string_literal: true

FactoryBot.define do
  factory :team_balance do
    balance { 91 }
    balance_date { "2022-09-01" }
    team_id { 1 }
    account_id { 1 }
  end
end
