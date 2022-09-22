# frozen_string_literal: true

FactoryBot.define do
  factory :investment do
    value { 250000.00 }
    date { "#{1.month.ago.to_date}" }
    team
  end
end
