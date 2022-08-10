# frozen_string_literal: true

FactoryBot.define do
  factory :metric_limit do
    indicator_type { "balance" }
    label { "MyString" }
    low_priority_min { 90 }
    low_priority_max { 100 }
    medium_priority_min { 80 }
    medium_priority_max { 89 }
    high_priority_min { 0 }
    high_priority_max { 79 }
  end
end
