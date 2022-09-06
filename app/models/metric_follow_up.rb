# frozen_string_literal: true

class MetricFollowUp < ApplicationRecord
  belongs_to :account
  belongs_to :manager, class_name: "Collaborator", foreign_key: :manager_id

  has_many :metric_histories

  enum alert_status: { in_progress: 0, solved: 1, blocked: 2 }
  enum metric_type: METRICS_TYPES
end
