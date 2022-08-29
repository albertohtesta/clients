# frozen_string_literal: true

class MetricHistoryPresenter < ApplicationPresenter
  ATTRS = %i[id metric_follow_ups_id date alert_status].freeze
  METHODS = [:mitigation_strategy].freeze

  def mitigation_strategy
    MetricFollowUpRepository.mitigation_strategy(metric_follow_ups_id)
  end
end
