# frozen_string_literal: true

FactoryBot.define do
  factory :metric_history do
    metric_follow_up
    date { Date.today }
  end
end
