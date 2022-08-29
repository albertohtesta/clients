# frozen_string_literal: true

class MetricFollowUp < ApplicationRecord
  belongs_to :account
  belongs_to :manager, class_name: "Collaborator", foreign_key: :manager_id

  has_many :metric_histories

  enum metric_type: METRICS_TYPES
  validates :follow_date, :mitigation_strategy, presence: true
end
