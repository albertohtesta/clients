# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    added_date { "2022-06-14 13:19:29" }
    team_type { build(:team_type) }
  end
end
