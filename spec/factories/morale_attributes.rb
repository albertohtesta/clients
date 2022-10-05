# frozen_string_literal: true

FactoryBot.define do
  factory :morale_attribute do
    name { "ORGULLO" }
    trait :with_questions do
      after(:create) do |morale_attribute|
        FactoryBot.create(:survey_question, morale_attribute:)
        FactoryBot.create(:survey_question, question: "question02", morale_attribute:)
      end
    end
  end

  factory :survey_question do
    question { "question01" }
    morale_attribute
  end
end
