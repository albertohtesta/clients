# frozen_string_literal: true

class PresenterMetricService < ApplicationService
  def initialize(grouped_by, filter_params)
    @grouped_by = grouped_by
    @filter_params = filter_params
  end

  def present
    {
      "monthly" => MetricRepository.team_metrics_per_month(filter_params),
      "quarter" => MetricRepository.team_metrics_per_quarter(filter_params)
    }[grouped_by]
  end

  private
    attr_reader :grouped_by, :filter_params
end
