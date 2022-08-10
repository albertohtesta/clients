# frozen_string_literal: true

class MetricLimit < ApplicationRecord
  enum indicator_type: METRICS_TYPES
end
