# frozen_string_literal: true

module MetricPriority
  class PriorityCalculatorRepository < ApplicationRepository
    def initialize(account, metric_type)
      @account = account
      @metric_type = metric_type
    end

    def priority
      {
        amount: calculate_amount || 0,
        alert: nivel_of_priority
      }
    end

    private
      attr_reader :account, :metric_type

      def calculate_amount
        account_metric_result[metric_type]
      end

      def nivel_of_priority
        return true if high_rate? || medium_rate?

        false
      end

      def account_metric_result
        @account_metric_result ||= account.metrics
          .where(date: 1.months.ago..Date.today)
          .group("indicator_type").sum("value")
      end

      def find_metric_limit(metric_limits)
        metric_limits.find_by(indicator_type: metric_type)
      end

      def high_rate?
        high_metric_limit = find_metric_limit(high_metric_limits)
        result = account_metric_result[metric_type]

        return false if result.nil?

        result.between?(high_metric_limit.min, high_metric_limit.max)
      end

      def medium_rate?
        medium_metric_limit = find_metric_limit(medium_metric_limits)
        result = account_metric_result[metric_type]

        return false if result.nil?

        result.between?(medium_metric_limit.min, medium_metric_limit.max)
      end

      def high_metric_limits
        @high_metric_limits ||= MetricLimit.select("high_priority_min AS min", "high_priority_max AS max", "indicator_type")
      end

      def medium_metric_limits
        @medium_metric_limits ||= MetricLimit.select("medium_priority_min AS min", "medium_priority_max AS max", "indicator_type")
      end
  end
end
