# frozen_string_literal: true

FactoryBot.define do
  factory :morale_attribute do
    name { "ORGULLO" }
    trait :with_questions do
      after(:create) do |morale_attribute|
        create(:survey_question, morale_attribute:)
        create(:survey_question, question: "question02", morale_attribute:)
      end
    end
  end
end
