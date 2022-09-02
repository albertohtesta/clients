# frozen_string_literal: true

class MoraleAttribute < ApplicationRecord
  has_many :survey_questions
  validates :name, presence: true
end
