# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    status { 0 }
    survey_url { "MyString" }
    requested_answers { 1 }
    current_answers { 1 }
    deadline { Date.today + 1.month }
    period { 1 }
    period_value { 1 }
    questions_detail { "" }
    answers_detail { "" }
    description { "New survey for this team" }
    team

    trait :deadline_one_month do
      deadline { Date.today + 1.month }
    end

    trait :period_value_current_month do
      period_value { Date.today.month }
    end

    trait :started_at_today do
      started_at { Date.today }
    end

    trait :current_year do
      year { Date.today.year }
    end

    trait :period_monthly do
      period { "month" }
    end

    factory :survey_with_dates, traits: [:deadline_one_month, :period_value_current_month,
                                         :started_at_today, :current_year, :period_monthly]
  end
end
