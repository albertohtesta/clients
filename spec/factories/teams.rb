# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    added_date { "2022-06-14 13:19:29" }
    team_type
    project
    monthly_amount { 45000.00 }
  end
end
