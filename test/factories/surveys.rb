# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    status { 0 }
    survey_url { "MyString" }
    requested_answers { 1 }
    current_answers { 1 }
    deadline { "2022-08-03" }
    period { 1 }
    questions_detail { "" }
    answers_detail { "" }
    team
  end
end
