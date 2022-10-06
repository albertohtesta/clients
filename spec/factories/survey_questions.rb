# frozen_string_literal: true

FactoryBot.define do
  factory :survey_question do
    question { "question01" }
    morale_attribute
  end
end
