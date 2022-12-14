# frozen_string_literal: true

class Metric < ApplicationRecord
  belongs_to :related, polymorphic: true
  validates :date, :value, :indicator_type, presence: true

  enum indicator_type: METRICS_TYPES
end
