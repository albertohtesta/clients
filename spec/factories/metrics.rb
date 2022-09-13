# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    related { association [:team, :account].sample }
    value { 75 }
    date { Date.today.beginning_of_year }
    indicator_type { "performance" }
  end
end
