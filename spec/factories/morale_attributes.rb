# frozen_string_literal: true

FactoryBot.define do
  factory :survey_question do
    question { "question01" }
    morale_attribute
  end

  factory :morale_attribute do
    name { "ORGULLO" }
  end
end

def morale_attribute_with_survey_questions
  FactoryBot.create(:morale_attribute) do |morale_attribute|
    FactoryBot.create(:survey_question, morale_attribute:)
    FactoryBot.create(:survey_question, question: "question02", morale_attribute:)
  end
end
