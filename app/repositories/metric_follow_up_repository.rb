# frozen_string_literal: true

class MetricFollowUpRepository < ApplicationRepository
  class << self
    def mitigation_strategy(id)
      scope.find_by(id:).mitigation_strategy
    end

    def add_follow_up(**args)
      id = args[:id]
      indicator_type = metric_record(id).indicator_type
      account_id = args[:account_id] ? args[:account_id].to_i : Account.find_by(manager_id: args[:manager_id]).id
      scope.create!(alert_status: args[:alert_status],
        mitigation_strategy: args[:mitigation_strategy],
        manager_id: args[:manager_id],
        account_id:,
        follow_date: Date.today,
        metric_type: indicator_type
      )
    end

    private
      def metric_record(id)
        record = Metric.find_by(id:)
        record || MetricFollowUp.find_by(id:)
      end
  end
end
