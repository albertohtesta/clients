# frozen_string_literal: true

FactoryBot.define do
  factory :metric_follow_up do
    follow_date { "2022-08-02" }
    metric_type { "morale" }
    account
    manager { association :collaborator }
    mitigation_strategy { "" }
    alert_status { 0 }
  end
end
