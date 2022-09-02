# frozen_string_literal: true

class SurveyQuestion < ApplicationRecord
  belongs_to :morale_attribute
  validates :question, presence: true
end
