# frozen_string_literal: true

class MetricRepository < ApplicationRepository
  class << self
    def get_metrics_per_project(from_date, to_date, params)
      scope.where("from_date <= ?", from_date).where("to_date >= ?", to_date).where(params).last
    end
  end
end
