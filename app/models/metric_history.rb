# frozen_string_literal: true

class MetricHistory < ApplicationRecord
  belongs_to :metric_follow_up, foreign_key: :metric_follow_ups_id, optional: true

  enum alert_status: { in_progress: 0, solved: 1, blocked: 2 }
end
