# frozen_string_literal: true

FactoryBot.define do
  factory :investment do
    value { 250000.00 }
    date { "#{Time.now.year}-11-19" }
    team
  end
end
