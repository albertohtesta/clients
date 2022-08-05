# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    related { association [:team, :account].sample }
    metrics { { "team_id" => 1, "date" => "21-05-2022", "value" => 75 }.to_json }
    date { Date.today.beginning_of_year }
    indicator_type { "performance" }
  end
end
