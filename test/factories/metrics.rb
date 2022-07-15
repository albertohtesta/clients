# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    project
    metrics { { "project_indicators": [
      { "id": 1, "label": "Q1", "value": 50 }, { "id": 2, "label": "Q2", "value": 70 } ] }.to_json
    }
    to_date { "2022-05-31" }
    from_date { "2022-01-01" }
    indicator_type { "performance" }
    group_by { "monthly" }
  end
end
