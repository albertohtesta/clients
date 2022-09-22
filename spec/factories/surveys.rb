# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    status { 0 }
    survey_url { "MyString" }
    requested_answers { 1 }
    current_answers { 1 }
    deadline { "2022-09-29" }
    period { 1 }
    period_value { 1 }
    questions_detail { "" }
    answers_detail { "" }
    description { "New survey for this team" }
    team
  end
end
