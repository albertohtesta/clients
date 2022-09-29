# frozen_string_literal: true

class MetricFollowUpRepository < ApplicationRepository
  class << self
    def mitigation_strategy(id)
      scope.find_by(id:).mitigation_strategy
    end

    def add_follow_up(**args)
      scope.create!(alert_status: args[:alert_status],
        mitigation_strategy: args[:mitigation_strategy],
        manager_id: args[:manager_id],
        account_id: account_id(args),
        follow_date: Date.today,
        metric_type: metric_type(args)
      )
    end

    private
      def account_id(args)
        return args[:account_id].to_i if args[:account_id]
        account = Account.find_by(manager_id: args[:manager_id])
        account ? account.id : 0
      end

      def metric_type(args)
        return args[:metric_type] if args[:metric_type]
        id = args[:id]
        metric = Metric.find_by(id:)
        metric ? metric.indicator_type : MetricFollowUp.find_by(id:).metric_type
      end
  end
end
