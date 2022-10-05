# frozen_string_literal: true

class MetricFollowUpRepository < ApplicationRepository
  class << self
    def mitigation_strategy(id)
      scope.find_by(id:).mitigation_strategy
    end

    def add_follow_up(**args)
      follow_up = scope.where(
        account_id: account_id(args),
        follow_date: Date.today,
        metric_type: metric_type(args)
      ).first_or_initialize
      follow_up.update!(alert_status: args[:alert_status],
        mitigation_strategy: args[:mitigation_strategy],
        manager_id: manager_id(args))
    end

    private
      def manager_id(args)
        args[:manager_id] ? args[:manager_id].to_i : Account.find(args[:account_id]).manager_id
      end

      def account_id(args)
        args[:account_id] ? args[:account_id].to_i : Account.find_by(manager_id: args[:manager_id]).id
      end

      def metric_type(args)
        return args[:metric_type] if args[:metric_type]

        id = args[:id]
        raise ArgumentError if id.nil?
        metric = Metric.find_by(id:)
        metric ? metric.indicator_type : MetricFollowUp.find_by(id:).metric_type
      end
  end
end
